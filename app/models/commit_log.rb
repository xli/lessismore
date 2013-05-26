class CommitLog < ActiveRecord::Base
  def identifier
    "#{id}_#{name.gsub(/\W/, '_')}"
  end

  def safe_repository_url
    repository_url.to_s.gsub(/:[^@:]*@/, ':*****@')
  end

  def commits
    if repo = git_repo
      repo.log.between(self.since, 'HEAD').to_a
    else
      []
    end
  rescue
    []
  end

  def data_dir
    Rails.root.join('data')
  end

  def repo_dir
    File.join(data_dir, identifier)
  end

  def git_repo
    if File.exists?(repo_dir)
      Git.bare(repo_dir, :bare => true, :log => Rails.logger)
    end
  end

  def update_repository
    FileUtils.mkdir_p(data_dir)
    if repo = git_repo
      Rails.logger.info("Fetch repository #{name}")
      repo.fetch
    else
      Rails.logger.info("Cloning repository #{name}")
      Git.clone(repository_url, identifier, :bare => true, :path => data_dir)
    end
  end
end
