require "bundler/setup"

require 'active_record'

Bundler.require

require_all 'app'
connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
