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

page_number = 0
events_response = @client.user_events(username, :page => page_number, :per_page => 100)
GithubService.extract_events(events_response)
latest_event_created_at = events_response.last[:created_at]
puts "EVENTS SINCE #{latest_event_created_at}"

while latest_event_created_at > 1.year.ago
  page_number += 1
  events_response = @client.user_events(username, :page => page_number, :per_page => 100)
  GithubService.extract_events(events_response)
  latest_event_created_at = events_response.last[:created_at]
  puts "EVENTS SINCE #{latest_event_created_at}"
end

#> In order to keep the API fast for everyone, pagination is limited for this resource. Check the rel=last link relation in the Link response header to see how far back you can traverse. // See: https://developer.github.com/v3/#pagination (Octokit::UnprocessableEntity)


=begin

while @client.last_response.rels[:next] # while there is a next page to get ...
  events_response = @client.last_response.rels[:next].get.data # get the next page
  GithubService.extract_events(events_response)
  latest_event_created_at = events_response.last[:created_at]
  puts "EVENTS SINCE #{latest_event_created_at}"

  binding.pry
  #binding.pry if latest_event_created_at < 1.year.ago
end

=end

=begin

page_number = 1
events_response = @client.user_events(username, :page => page_number, :per_page => 100)
GithubService.extract_events(events_response)
latest_event_created_at = events_response.last[:created_at]
puts "PAGE #{page_number} -- SINCE #{latest_event_created_at}"

while @client.last_response.rels[:next] # while there is a next page to get ...
  #events_response = @client.last_response.rels[:next].get.data # get the next page
  page_number+=1
  events_response = @client.user_events(username, :page => page_number, :per_page => 100)
  GithubService.extract_events(events_response)
  latest_event_created_at = events_response.last[:created_at]
  puts "PAGE #{page_number} -- SINCE #{latest_event_created_at}"

  binding.pry if latest_event_created_at < 1.year.ago
end

=end
