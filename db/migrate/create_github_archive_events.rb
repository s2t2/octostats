require_relative "../../lib/models.rb"

class CreateGitHubArchiveEvents < ActiveRecord::Migration
  def change
    create_table :github_archive_events, :id => false do |t|
      t.integer :id, :limit => 8, :null => false
      t.string :event_type
      t.integer :user
      t.integer :org
      t.integer :repo
      t.boolean :public
      t.datetime :created_at
    end

    add_index :github_archive_events, :id, :unique => true
    add_index :github_archive_events, :event_type
    add_index :github_archive_events, :user
    add_index :github_archive_events, :org
    add_index :github_archive_events, :repo
    add_index :github_archive_events, :public
    add_index :github_archive_events, :created_at
  end
end

CreateGitHubArchiveEvents.migrate(:up)
