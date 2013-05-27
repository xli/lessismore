class CreateContinuousDeployments < ActiveRecord::Migration
  def change
    create_table :continuous_deployments do |t|
      t.references :user, :null => false
      t.string :name
      t.string :deployed_revision_url
      t.string :deployed_revision_extract_regex
      t.string :git_repo_url
      t.boolean :git_repo_cloned

      t.timestamps
    end
  end
end
