require_relative "models.rb"

module GithubArchiveService
  def self.get_and_parse_events(page_number)
    response = GithubContributionsApi.user_events("s2t2", :page => page_number)
    puts response.reject{|e| e["events"]}

    if response["events"]
      response["events"].each do |e|
        unless e["_event_id"] # some events pre-2015 don't have an event_id (see https://github.com/tenex/github-contributions/issues/52#issue-130375804)
          puts e
          next
        end
        event = GithubArchiveEvent.where({:id => e["_event_id"]}).first_or_create!
        event.update_attributes!({
          :event_type => e["type"],
          :user => e["_user_lower"],
          :org => e["_org_lower"],
          :repo => e["_repo_lower"],
          :public => e["public"],
          :created_at => e["created_at"]
        })
      end
    end
    return response
  end
end
