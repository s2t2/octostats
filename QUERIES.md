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









<hr>









Other users and orgs in the user's github contribution network ("PushEvent" only).

```` sql
SELECT
  e.user
  ,split_part(e.repo,  '/',  1) AS repo_owner
  ,count(DISTINCT e.id) AS event_count
  ,min(e.created_at)::DATE AS first_contribution_on
  ,max(e.created_at)::DATE AS latest_contribution_on
  ,(max(e.created_at)::DATE - min(e.created_at)::DATE) AS relationship_length_days
  ,count(DISTINCT e.created_at::DATE) AS contribution_days
  ,count(DISTINCT e.id) / count(DISTINCT e.created_at::DATE) AS contribs_per_day
FROM github_archive_events e
WHERE e.event_type = 'PushEvent'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 25
````

=>

user | repo_owner | event_count | first_contribution_on | latest_contribution_on | relationship_length_days | contribution_days | contribs_per_day
--- | --- | --- | --- | --- | --- | --- | ---
s2t2 | gwu-business | 412 | 2015-08-24 | 2016-01-31 | 160 | 99 | 4
s2t2 | s2t2 | 366 | 2012-11-13 | 2016-03-17 | 1220 | 133 | 2
s2t2 | data-creative | 93 | 2015-01-25 | 2016-03-16 | 416 | 31 | 3
s2t2 | debate-watch | 69 | 2015-05-22 | 2016-03-16 | 299 | 25 | 2
s2t2 | codeforamerica | 41 | 2016-01-27 | 2016-02-03 | 7 | 7 | 5
s2t2 | opensaltlake | 36 | 2016-02-20 | 2016-03-01 | 10 | 8 | 4
s2t2 | databyday | 26 | 2014-10-12 | 2015-01-09 | 89 | 13 | 2
s2t2 | kuanb | 24 | 2016-01-22 | 2016-01-26 | 4 | 4 | 6
s2t2 | slco-2016 | 20 | 2016-03-05 | 2016-03-09 | 4 | 4 | 5
s2t2 | grantbot | 5 | 2015-02-21 | 2015-02-22 | 1 | 2 | 2
s2t2 | sfbrigade | 3 | 2015-05-02 | 2015-05-08 | 6 | 2 | 1
s2t2 | open-retirement | 2 | 2015-06-03 | 2015-06-03 | 0 | 1 | 2


Repos most contributed-to (all `event_type`).

```` sql
SELECT
  e.user
  ,e.repo
  ,count(DISTINCT e.id) AS event_count
  ,min(e.created_at)::DATE AS first_contribution_on
  ,max(e.created_at)::DATE AS latest_contribution_on
FROM github_archive_events e
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 25
````

=>

user | repo | event_count | first_contribution_on | latest_contribution_on
--- | --- | --- | --- | ---
s2t2 | gwu-business/istm-4121 | 333 | 2015-08-25 | 2016-01-03
s2t2 | gwu-business/badm-2301 | 192 | 2015-08-24 | 2016-01-04
s2t2 | opensaltlake/utah-court-calendar-service | 75 | 2016-02-20 | 2016-03-08
s2t2 | s2t2/branford_station | 66 | 2015-01-25 | 2015-09-03
s2t2 | codeforamerica/courtbot-reporter | 59 | 2016-01-27 | 2016-02-03
s2t2 | s2t2/s2t2.github.io | 57 | 2014-12-27 | 2015-09-13
s2t2 | kuanb/atl_zoink | 57 | 2016-01-22 | 2016-02-03
s2t2 | data-creative/data-creative.github.io | 47 | 2015-03-21 | 2016-03-01
s2t2 | s2t2/gsa-hackathon-2015 | 37 | 2015-10-16 | 2015-10-23
s2t2 | s2t2/clubhouse-cookbook | 34 | 2015-11-03 | 2015-12-02
s2t2 | slco-2016/slco-court-calendar-service | 32 | 2016-03-05 | 2016-03-09
s2t2 | debate-watch/twenty_sixteen | 31 | 2015-07-03 | 2016-03-16
s2t2 | debate-watch/debate-watch | 27 | 2015-08-07 | 2015-09-26
s2t2 | s2t2/train_tracker | 23 | 2012-11-30 | 2012-12-30
s2t2 | gwu-business/bikeshare-data | 21 | 2015-10-25 | 2015-11-13
s2t2 | s2t2/scalding-fireworks | 21 | 2013-01-14 | 2013-09-08
s2t2 | gwu-business/george-lms | 19 | 2015-09-07 | 2016-01-04
s2t2 | gwu-business/radio-data | 18 | 2015-10-21 | 2016-01-25
s2t2 | s2t2/gtfs_mail | 18 | 2013-02-13 | 2013-04-01
s2t2 | debate-watch/poc | 16 | 2015-05-22 | 2015-06-20
s2t2 | debate-watch/open-fec-api-ruby | 16 | 2015-07-21 | 2015-12-27
s2t2 | databyday/gtfs-data-exchange-api-ruby | 15 | 2014-11-28 | 2014-12-07
s2t2 | s2t2/s2t2.github.com | 14 | 2012-12-12 | 2012-12-12
s2t2 | gwu-business/salad-site | 13 | 2015-11-13 | 2015-11-15
s2t2 | data-creative/gtfs-data-exchange-api-ruby | 13 | 2015-01-25 | 2015-02-15

Repos most contributed-to ("PushEvent" only).

```` sql
SELECT
  e.user
  ,e.repo
  ,count(DISTINCT e.id) AS event_count
  ,min(e.created_at)::DATE AS first_contribution_on
  ,max(e.created_at)::DATE AS latest_contribution_on
FROM github_archive_events e
WHERE e.event_type = 'PushEvent'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 25
````

=>

user | repo | event_count | first_contribution_on | latest_contribution_on
--- | --- | --- | --- | ---
s2t2 | gwu-business/istm-4121 | 191 | 2015-08-25 | 2016-01-03
s2t2 | gwu-business/badm-2301 | 107 | 2015-08-24 | 2016-01-04
s2t2 | s2t2/s2t2.github.io | 57 | 2014-12-27 | 2015-09-13
s2t2 | data-creative/data-creative.github.io | 46 | 2015-03-21 | 2016-03-01
s2t2 | codeforamerica/courtbot-reporter | 41 | 2016-01-27 | 2016-02-03
s2t2 | s2t2/branford_station | 38 | 2015-01-25 | 2015-09-03
s2t2 | opensaltlake/utah-court-calendar-service | 36 | 2016-02-20 | 2016-03-01
s2t2 | s2t2/gsa-hackathon-2015 | 29 | 2015-10-16 | 2015-10-23
s2t2 | s2t2/clubhouse-cookbook | 25 | 2015-11-03 | 2015-12-02
s2t2 | kuanb/atl_zoink | 24 | 2016-01-22 | 2016-01-26
s2t2 | s2t2/train_tracker | 21 | 2012-11-30 | 2012-12-30
s2t2 | s2t2/scalding-fireworks | 21 | 2013-01-14 | 2013-09-08
s2t2 | slco-2016/slco-court-calendar-service | 20 | 2016-03-05 | 2016-03-09
s2t2 | s2t2/gtfs_mail | 18 | 2013-02-13 | 2013-04-01
s2t2 | gwu-business/george-lms | 18 | 2015-09-07 | 2016-01-04
s2t2 | debate-watch/twenty_sixteen | 16 | 2015-07-05 | 2016-03-16
s2t2 | debate-watch/poc | 16 | 2015-05-22 | 2015-06-20
s2t2 | s2t2/s2t2.github.com | 14 | 2012-12-12 | 2012-12-12
s2t2 | debate-watch/open-fec-api-ruby | 13 | 2015-07-21 | 2015-12-27
s2t2 | s2t2/us-chronic-disease-indicators | 12 | 2015-12-12 | 2015-12-13
s2t2 | gwu-business/salad-site | 12 | 2015-11-13 | 2015-11-15
s2t2 | s2t2/trailmix-solo | 11 | 2015-01-03 | 2015-07-07
s2t2 | debate-watch/alpha | 11 | 2016-01-11 | 2016-01-24
s2t2 | debate-watch/youtube-data-api-ruby | 11 | 2015-10-11 | 2015-10-23
s2t2 | s2t2/trailmix | 10 | 2015-01-02 | 2015-01-03

Repos most contributed-to, by `event_type`.

```` sql
SELECT
  e.user
  ,e.repo
  ,e.event_type
  ,count(DISTINCT e.id) AS event_count
  ,min(e.created_at)::DATE AS first_contribution_on
  ,max(e.created_at)::DATE AS latest_contribution_on
FROM github_archive_events e
GROUP BY 1,2,3
ORDER BY 4 DESC
LIMIT 25
````

=>

user | repo | event_type | event_count | first_contribution_on | latest_contribution_on
--- | --- | --- | --- | --- | ---
s2t2 | gwu-business/istm-4121 | PushEvent | 191 | 2015-08-25 | 2016-01-03
s2t2 | gwu-business/badm-2301 | PushEvent | 107 | 2015-08-24 | 2016-01-04
s2t2 | gwu-business/istm-4121 | IssuesEvent | 81 | 2015-08-28 | 2015-12-23
s2t2 | s2t2/s2t2.github.io | PushEvent | 57 | 2014-12-27 | 2015-09-13
s2t2 | gwu-business/istm-4121 | IssueCommentEvent | 56 | 2015-09-03 | 2016-01-03
s2t2 | gwu-business/badm-2301 | IssuesEvent | 52 | 2015-08-28 | 2015-12-23
s2t2 | data-creative/data-creative.github.io | PushEvent | 46 | 2015-03-21 | 2016-03-01
s2t2 | codeforamerica/courtbot-reporter | PushEvent | 41 | 2016-01-27 | 2016-02-03
s2t2 | s2t2/branford_station | PushEvent | 38 | 2015-01-25 | 2015-09-03
s2t2 | opensaltlake/utah-court-calendar-service | PushEvent | 36 | 2016-02-20 | 2016-03-01
s2t2 | gwu-business/badm-2301 | IssueCommentEvent | 31 | 2015-08-31 | 2016-01-03
s2t2 | s2t2/gsa-hackathon-2015 | PushEvent | 29 | 2015-10-16 | 2015-10-23
s2t2 | s2t2/clubhouse-cookbook | PushEvent | 25 | 2015-11-03 | 2015-12-02
s2t2 | opensaltlake/utah-court-calendar-service | IssuesEvent | 25 | 2016-02-20 | 2016-03-08
s2t2 | kuanb/atl_zoink | PushEvent | 24 | 2016-01-22 | 2016-01-26
s2t2 | s2t2/train_tracker | PushEvent | 21 | 2012-11-30 | 2012-12-30
s2t2 | s2t2/scalding-fireworks | PushEvent | 21 | 2013-01-14 | 2013-09-08
s2t2 | slco-2016/slco-court-calendar-service | PushEvent | 20 | 2016-03-05 | 2016-03-09
s2t2 | kuanb/atl_zoink | IssueCommentEvent | 19 | 2016-01-23 | 2016-02-03
s2t2 | gwu-business/george-lms | PushEvent | 18 | 2015-09-07 | 2016-01-04
s2t2 | s2t2/gtfs_mail | PushEvent | 18 | 2013-02-13 | 2013-04-01
s2t2 | debate-watch/twenty_sixteen | PushEvent | 16 | 2015-07-05 | 2016-03-16
s2t2 | debate-watch/poc | PushEvent | 16 | 2015-05-22 | 2015-06-20
s2t2 | debate-watch/debate-watch | IssuesEvent | 15 | 2015-08-07 | 2015-09-18
s2t2 | s2t2/branford_station | GollumEvent | 15 | 2015-04-06 | 2015-05-03
