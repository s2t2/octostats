require 'pry'
require_relative "models.rb"

module GithubService
  ACCESS_TOKEN = ENV["OCTOSTATS_GITHUB_ACCESS_TOKEN"]

  def self.extract_user(user_response)
    user = GithubUser.where({:id => user_response[:id]}).first_or_create!
    user.update_attributes!({
      :user_type => user_response[:type],
      :username => user_response[:login],
      :name => user_response[:name],
      :followers => user_response[:followers],
      :following => user_response[:following],
      :avatar_url => user_response[:avatar_url],
      :blog_url => user_response[:blog],
      :created_at => user_response[:created_at],
      :updated_at => user_response[:updated_at]
    })
  end

  # @param [Array] events_response An array of event objects returned by the octokit client.
  def self.extract_events(events_response)
    events_response.each do |e|
      event = GithubEvent.where({:id => e[:id]}).first_or_create!
      event.update_attributes!({
        :event_type => e[:type],
        :github_user_id => e[:actor].try(:id),
        :github_org_id => e[:org].try(:id),
        :github_repo_id => e[:repo].try(:id),
        :payload => e[:payload],
        :public => e[:public],
        :created_at => e[:created_at]
      })
    end
  end
end
