require 'pry'
require 'pp'
require 'github_contributions_api'
require_relative '../lib/github_archive_service'

include GithubArchiveService

user = GithubContributionsApi.user("s2t2")

page_number = 1
events = GithubArchiveService.get_and_parse_events(page_number)
while events["size"] > 0
  page_number += 1
  events = GithubArchiveService.get_and_parse_events(page_number)
end
