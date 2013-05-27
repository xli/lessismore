class CreateDeployedRevisions < ActiveRecord::Migration
  def change
    create_table :deployed_revisions do |t|
      t.references :continuous_deployment, :null => false
      t.string :version, :null => false

      t.timestamps
    end
  end
end
