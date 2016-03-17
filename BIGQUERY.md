## Github Archive Google BigQuery


```` sql
SELECT
  id
  ,Row
  ,type
  ,public
  ,repo_id
  ,repo_name
  ,repo_url
  ,actor_id
  ,actor_login
  ,actor_gravatar_id
  ,actor_gravatar_url
  ,org_id
  ,org_login
  ,org_gravatar_id
  ,org_gravatar_url
  ,org_url
  ,created_at
  ,payload
-- FROM [githubarchive:day.events_20150413]
FROM (TABLE_DATE_RANGE([githubarchive:day.events_],
    TIMESTAMP('2015-01-01'),
    TIMESTAMP('2015-12-31')
  ))
where actor.login = "s2t2"
LIMIT 1000
````
