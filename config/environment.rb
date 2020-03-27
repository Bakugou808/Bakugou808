
require 'bundler'
require "bundler/setup"
require "sinatra/activerecord"
require "uri"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil


require_all 'app'
require_all 'app/models'

