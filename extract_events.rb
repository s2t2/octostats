require 'octokit'
require 'pry'
require 'pp'

ACCESS_TOKEN = ENV["OCTOSTATS_GITHUB_ACCESS_TOKEN"]
raise "MISSING ACCESS TOKEN" unless ACCESS_TOKEN

@client = Octokit::Client.new(:access_token => ACCESS_TOKEN)

#
# USER
#

user = @client.user
pp ({
  :id => user[:id],
  :type => user[:type],
  :login => user[:login],
  :name => user[:name],
  :followers => user[:followers],
  :following => user[:following],
  :avatar_url => user[:avatar_url],
  :blog_url => user[:blog],
  :created_at => user[:created_at],
  :updated_at => user[:updated_at]
})

#
# USER EVENTS
#

# @param [Array] user_events
def extract_user_events(user_events)
  @counter += user_events.count
  puts "#{@counter} EVENTS"
  #user_events.each do |user_event|
  #  pp ({
  #    :id => user_event[:id],
  #    :type => user_event[:type],
  #    :actor_id => user_event[:actor][:id],
  #    :org_id => user_event[:org][:id],
  #    :repo_id => user_event[:repo][:id],
  #    #:payload => user_event[:payload],
  #    :public => user_event[:public],
  #    :created_at => user_event[:created_at]
  #  })
  #end
end

@counter = 0
user_events = @client.user_events(user[:login], :per_page => 100)
extract_user_events(user_events)
while @client.last_response.rels[:next]
  user_events = @client.last_response.rels[:next].get.data
  extract_user_events(user_events)
end

# USER REPOS CONTRIBUTED TO

# USER COMMITS
