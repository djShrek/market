#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/environment', __FILE__)

require File.expand_path('../config/application', __FILE__)

DotaMarket::Application.load_tasks

desc 'Say Hi'
task :hello do
  User.connection
  User.hi
end