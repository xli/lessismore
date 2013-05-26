class ContinuousDeployment < ActiveRecord::Base

  def waiting_deployment_commits
    git_repo.commits(deployed_revision)
  end

  def safe_git_repo_url
    git_repo_url.to_s.gsub(/:[^@:]*@/, ':*****@')
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

  def deployed_revision
    @deployed_revision ||= DeployedRevision.new(self.deployed_revision_url, self.deployed_revision_extract_regex).fetch
  end

  private
  def git_repo
    @git_repo ||= GitRepo.new("#{self.id}_#{self.name.gsub(/\W/, '_')}", self.git_repo_url)
  end
end
