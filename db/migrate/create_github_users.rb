require_relative "../../lib/models.rb"

class CreateGitHubUsers < ActiveRecord::Migration
  def change
    create_table :github_users, :id => false do |t|
      t.integer :id, :limit => 8, :null => false
      t.string :user_type

      t.string :username
      t.string :name

      t.integer :followers
      t.integer :following

      t.string :avatar_url
      t.string :blog_url

      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :github_users, :id, :unique => true
    add_index :github_users, :user_type
    add_index :github_users, :username
  end
end

CreateGitHubUsers.migrate(:up)
