class CreateCommitLogs < ActiveRecord::Migration
  def change
    create_table :commit_logs do |t|
      t.string :name
      t.string :repository_url
      t.string :since
      t.string :until

      t.timestamps
    end
  end
end
