require 'pry'
require 'pp'
require 'github_contributions_api'
require_relative '../lib/github_archive_service'

include GithubArchiveService

username = "s2t2"

GithubArchiveService.extract_user(username)

page_number = 1
events = GithubArchiveService.extract_user_events(username, page_number)
while events["size"] > 0
  page_number += 1
  events = GithubArchiveService.extract_user_events(username, page_number)
end
