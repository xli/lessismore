class CommitLog < ActiveRecord::Base
  def identifier
    "#{id}_#{name.gsub(/\W/, '_')}"
  end

  def safe_repository_url
    repository_url.to_s.gsub(/:[^@:]*@/, ':*****@')
  end
end
