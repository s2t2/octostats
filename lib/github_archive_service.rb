require_relative "models.rb"

module GithubArchiveService

  def self.extract_user(username)
    response = GithubContributionsApi.user("s2t2")
    repo_count = response["repos"].count
    puts response.reject{|u| u["repos"] }.merge({"repoCount" => repo_count})

    user = GithubArchiveUser.where({:username => response["username"]}).first_or_create!
    user.update_attributes!({
      :repos => response["repos"],
      :event_count => response["event_count"]
    })
  end

  def self.extract_user_events(username, page_number)
    response = GithubContributionsApi.user_events(username, :page => page_number)
    puts response.reject{|e| e["events"]}

    if response["events"]
      response["events"].each do |e|
        event = GithubArchiveEvent.where({:gh_id => e["_id"]}).first_or_create!
        event.update_attributes!({
          :gh_event_id => e["_event_id"], # some events pre-2015 don't have an event_id (see https://github.com/tenex/github-contributions/issues/52#issue-130375804)
          :event_type => e["type"],
          :user => e["_user_lower"],
          :org => e["_org_lower"],
          :repo => e["_repo_lower"],
          :public => true,
          :created_at => e["created_at"]
          })
      end
    end

    return response
  end
end
