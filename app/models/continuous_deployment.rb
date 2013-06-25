class ContinuousDeployment < ActiveRecord::Base
  belongs_to :user
  has_many :deployed_revisions, -> { order 'id' }
  
  before_update :reset_git_repo_cloned_status

  def self.sync_all!
    Rails.logger.info("Start sync all")
    all.each(&:sync!)
    Rails.logger.info("Sync all done!")
  end

  def waiting_deployment_commits
    @wdc ||= git_repo.commits(deployed_revision)
  end
  
  def waiting_deployment_stories(commits = waiting_deployment_commits)
    stories = []
    commits.each do |c|
      message = /\#(\d+)/.match(c.message) unless c.blank?
      story_number = message.captures.first unless message.blank?
      stories << story_number unless story_number.blank?
    end
    stories.uniq!
    stories
  end

  def safe_git_repo_url
    git_repo_url.to_s.gsub(/:[^@:]*@/, ':*****@')
  end

  def sync!
    with_error_handler(:update_deployed_revision)
    with_error_handler(:update_repo)
  end

  def update_repo
    unless git_repo.exists?
      self.update_attribute(:git_repo_cloned, false)
    end

    if self.git_repo_cloned?
      git_repo.fetch
    else
      git_repo.clone
      self.update_attribute(:git_repo_cloned, true)
    end
  end

  def update_deployed_revision
    revision = DeployedRevision.fetch(self.deployed_revision_url, self.deployed_revision_extract_regex)
    if revision && revision != deployed_revision
      self.deployed_revisions.create!(version: revision)
    end
  end

  def deployed_revision
    deployed_revisions.last.try(:version)
  end

  def git_repo
    @git_repo ||= GitRepo.new(self.id, self.git_repo_url)
  end

  private
  def reset_git_repo_cloned_status
    self.git_repo_cloned = false if self.git_repo_url_changed?
    true
  end

  def with_error_handler(subject)
    send(subject)
  rescue => e
    Rails.logger.error("Error when #{subject} #{self.name}: #{e.message}\n#{e.backtrace.join("\n")}")
  end
end
