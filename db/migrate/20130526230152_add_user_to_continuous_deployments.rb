class AddUserToContinuousDeployments < ActiveRecord::Migration
  def change
    add_column :continuous_deployments, :user_id, :integer, :null => false
  end
end
