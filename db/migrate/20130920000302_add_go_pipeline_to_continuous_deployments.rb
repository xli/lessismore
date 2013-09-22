class AddGoPipelineToContinuousDeployments < ActiveRecord::Migration
  def change
    add_column :continuous_deployments, :go_pipeline_name, :string
    add_column :continuous_deployments, :go_login, :string
    add_column :continuous_deployments, :go_password, :string
  end
end
