require 'octokit'
require 'pry'
require 'pp'
require_relative '../lib/github_service'
require_relative '../lib/models'

include GithubService

@client = Octokit::Client.new(:access_token => ACCESS_TOKEN)

user_response = @client.user
GithubService.extract_user(user_response)

username = user_response[:login]
events_response = @client.user_events(username, :per_page => 100)
GithubService.extract_events(events_response)
latest_event_created_at = events_response.last[:created_at]
puts latest_event_created_at

while @client.last_response.rels[:next] && latest_event_created_at > 1.year.ago # while there is a next page to get ...
  events_response = @client.last_response.rels[:next].get.data # get the next page
  GithubService.extract_events(events_response)
  latest_event_created_at = events_response.last[:created_at]
  puts latest_event_created_at
end
