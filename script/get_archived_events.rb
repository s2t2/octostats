require 'httparty'
require 'pry'
require 'pp'
require 'github_contributions_api'

response = GithubContributionsApi.user("s2t2")

page_number = 1

events = GithubContributionsApi.user_events("s2t2", :page => page_number)
puts events.reject{|e| e["events"]}

while events["size"] > 0
  page_number += 1
  events = GithubContributionsApi.user_events("s2t2", :page => page_number)
  puts events.reject{|e| e["events"]}
end
