
class GitRepo
  def self.data_dir
    Rails.root.join('data').tap do |dir|
      FileUtils.mkdir_p(dir)
    end
  end

  def initialize(cd_id, url)
    @url = url
    @identifier = "#{cd_id}_#{File.basename(url).split('.').first}"
  end

  def repo_dir
    File.join(GitRepo.data_dir, @identifier)
  end

  def commits(from, to='HEAD')
    if from && (repo = git_repo)
      repo.log(100000).between(from, to).to_a
    end
  end

  def clone
    Rails.logger.info("Cloning repository #{@identifier}")
    output = %x[git clone --mirror '#{escape(@url)}' '#{escape(repo_dir)}' 2>&1]
    Rails.logger.info(output)
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
  def escape(str)
    str.gsub(/'/, '')
  end
  def git_repo
    if exists?
      Git.bare(repo_dir, :bare => true, :log => Rails.logger)
    end
  end
end
