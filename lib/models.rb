require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  username: 'octocat',
  password: '0ct0cat',
  database: 'octostats_dev',
  encoding: 'unicode',
  pool: 5
)

class GithubUser < ActiveRecord::Base
  self.primary_key = :id
end

class GithubEvent < ActiveRecord::Base
  self.primary_key = :id
  serialize(:payload, Hash)
end
