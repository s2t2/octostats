require_relative "../../lib/models.rb"

class CreateGitHubArchiveUsers < ActiveRecord::Migration
  def change
    create_table :github_archive_users do |t|
      t.string :username, :null => false
      t.text :repos
      t.integer :event_count

      t.timestamps
    end

    add_index :github_archive_users, :username, :unique => true
  end
end

CreateGitHubArchiveUsers.migrate(:up)
