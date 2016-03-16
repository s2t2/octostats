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

page_number = 1
events_response = @client.user_events(username, :page => page_number, :per_page => 100)
GithubService.extract_events(events_response)
latest_event_created_at = events_response.last[:created_at]
puts "PAGE #{page_number} -- EVENTS SINCE #{latest_event_created_at}"

while latest_event_created_at > 1.year.ago # this condition never gets hit
  page_number += 1
  begin
    events_response = @client.user_events(username, :page => page_number, :per_page => 100)
  rescue Octokit::UnprocessableEntity => e
    exit if e.message.include?("pagination is limited for this resource")
  end
  GithubService.extract_events(events_response)
  latest_event_created_at = events_response.last[:created_at]
  puts "PAGE #{page_number} -- EVENTS SINCE #{latest_event_created_at}"
end
