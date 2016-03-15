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

### Usage

```` sh
ruby extract.rb
````
