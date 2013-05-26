
class GitRepo
  def self.data_dir
    Rails.root.join('data').tap do |dir|
      FileUtils.mkdir_p(dir)
    end
  end

  def initialize(identifier, url)
    @identifier, @url = identifier, url
  end

  def repo_dir
    File.join(GitRepo.data_dir, @identifier)
  end

  def commits(from, to='HEAD')
    if from && (repo = git_repo)
      repo.log.between(from, to).to_a
    end
  end

  def clone
    Rails.logger.info("Cloning repository #{@identifier}")
    Git.clone(@url, @identifier, :bare => true, :path => GitRepo.data_dir)
  end

  def fetch
    if repo = git_repo
      Rails.logger.info("Fetch repository #{@identifier}")
      repo.fetch
    end
  end

  def exists?
    File.exists?(repo_dir)
  end

  private
  def git_repo
    if exists?
      Git.bare(repo_dir, :bare => true, :log => Rails.logger)
    end
  end
end
