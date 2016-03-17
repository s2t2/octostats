# Octostats

## Contributing

### Prerequisites

Login to github,
 navigate to settings, and
 generate a new personal access token using the following scopes:

  + repo:status
  + repo_deployment
  + public_repo
  + read:org
  + gist
  + notifications
  + user:email
  + user:follow

### Installation

[Install](http://data-creative.info/process-documentation/2015/07/18/how-to-set-up-a-mac-development-environment.html#ruby) ruby and bundler.

[Install](http://data-creative.info/process-documentation/2015/07/18/how-to-set-up-a-mac-development-environment.html#postgresql) postgresql.

Download source code and install package dependencies.

```` sh
git clone git@github.com:s2t2/octostats.git
cd octostats/
bundle install
````

Create database user.

```` sh
psql
CREATE USER octocat WITH ENCRYPTED PASSWORD '0ct0cat!';
ALTER USER octocat CREATEDB;
ALTER USER octocat WITH SUPERUSER;
\q
````

Create database.

```` sh
psql -U octocat --password -d postgres -f $(pwd)/db/create.sql
````

Micgrate database.

```` sh
ruby db/migrate/create_github_users.rb
ruby db/migrate/create_github_events.rb
````

### Usage

```` sh
ruby script/extract_user_events.rb
ruby script/get_archived_events.rb
````
