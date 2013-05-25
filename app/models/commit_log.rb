class CommitLog < ActiveRecord::Base
  def safe_repository_url
    repository_url.to_s.gsub(/:[^@:]*@/, ':*****@')
  end
end
