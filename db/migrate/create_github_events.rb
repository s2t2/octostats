require_relative "../../lib/models.rb"

class CreateGitHubEvents < ActiveRecord::Migration
  def change
    create_table :github_events, :id => false do |t|
      t.integer :id, :limit => 8, :null => false
      t.string :event_type
      t.integer :github_user_id
      t.integer :github_org_id
      t.integer :github_repo_id
      t.text :payload
      t.boolean :public
      t.datetime :created_at
    end

    add_index :github_events, :id, :unique => true
    add_index :github_events, :event_type
    add_index :github_events, :github_user_id
    add_index :github_events, :github_org_id
    add_index :github_events, :github_repo_id
    add_index :github_events, :public
  end
end

CreateGitHubEvents.migrate(:up)
