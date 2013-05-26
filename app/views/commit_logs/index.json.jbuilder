json.array!(@commit_logs) do |commit_log|
  json.extract! commit_log, :name, :repository_url, :since
  json.url commit_log_url(commit_log, format: :json)
end