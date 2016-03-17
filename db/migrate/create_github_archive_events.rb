require_relative "../../lib/models.rb"

class CreateGitHubArchiveEvents < ActiveRecord::Migration
  def change
    create_table :github_archive_events do |t|
      t.string :gh_id
      t.integer :gh_event_id, :limit => 8 # not all events have event_ids
      t.string :event_type
      t.string :user
      t.string :org
      t.string :repo
      t.boolean :public
      t.datetime :created_at
    end

    add_index :github_archive_events, :gh_id
    add_index :github_archive_events, :gh_event_id
    add_index :github_archive_events, :event_type
    add_index :github_archive_events, :user
    add_index :github_archive_events, :org
    add_index :github_archive_events, :repo
    add_index :github_archive_events, :public
    add_index :github_archive_events, :created_at
  end
end

CreateGitHubArchiveEvents.migrate(:up)
