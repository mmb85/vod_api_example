# README

An example of RESTful API on rails  and ruby 2.6

* Ruby version
  - 2.6.5
* Rails version
  - 6.0.2.1
* Configuration
  - Clone repo and set correct version of rails/ruby using RBENV i.e. and run bundle install
* Database creation and initialization
  - Run this script to drop previous database and generate new data based on seed.rb that generate ramdon data 
  ```bundle exec rake db:drop && bundle exec rake db:prepare && bundle exec rake db:seed```    
* How to run the test suite
  - Rspec and Simplecov is part of gemfile so run bundle exec rspec and check later ```coverage/index.html``` to see the coverage of the application
* Services (job queues, cache servers, search engines, etc.)

