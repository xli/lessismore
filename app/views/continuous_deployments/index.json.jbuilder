json.array!(@continuous_deployments) do |continuous_deployment|
  json.extract! continuous_deployment, :name, :deployed_revision_url, :deployed_revision_extract_regex, :git_repo_url, :git_repo_cloned
  json.url continuous_deployment_url(continuous_deployment, format: :json)
end