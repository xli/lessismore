class CreateDeployedRevisions < ActiveRecord::Migration
  def change
    create_table :deployed_revisions do |t|
      t.string :version
      t.references :continuous_deployment

      t.timestamps
    end
  end
end
