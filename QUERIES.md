# Queries

```` sql
SELECT
  e.github_user_id AS user_id
  ,e.github_org_id AS org_id
  ,e.github_repo_id AS repo_id

  ,e.id AS event_id
  ,e.event_type
  ,e.public
  ,e.payload
FROM github_events e
````

```` sql
SELECT
 event_type
 ,count(DISTINCT id) AS event_count
FROM github_events
GROUP BY 1
ORDER BY 2 desc
````

=>

event_type | event_count
--- | ----
PushEvent | 116
IssuesEvent | 57
IssueCommentEvent | 40
CreateEvent | 33
PullRequestEvent | 32
WatchEvent | 22
ForkEvent | 2

> Always be pushing.
