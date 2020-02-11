# README

An example of RESTful API on rails  and ruby 2.6

* Ruby version
  - 2.6.5
* Rails version
  - 6.0.2.1
* Configuration
  - Clone repo and set correct version of rails/ruby using RBENV i.e.
  - Run bundle install
  - Open new terminal and run Sidekiq with ```bundle exec sidekiq``` to manage cache updates
* Database creation and initialization
  - Run this script to drop previous database and generate new data based on seed.rb that generate ramdon data 
  ```bundle exec rake db:drop && bundle exec rake db:prepare && bundle exec rake db:seed```    
* How to run the test suite
  - Rspec and Simplecov is part of gemfile so run ```bundle exec rspec``` and check later ```coverage/index.html``` to see the coverage of the application.
* Services
  - Redis is used as cache mecanism storing keys and expiring on each creation/deletion/update.
  - Sidekiq was enabled to manage cache in background. I.E. when an episode was created also season should be refresh so both jobs will run with the update to grant season endpoit have the correct updating the cache.

## Some util endpoints
- Return the movies, ordered by creation
  ```localhost:3000/movies/```
- Return the seasons ordered by creation, including the list of episodes ordered by its number.
  ```localhost:3000/seasos/```
- An endpoint to return both movies and seasons, ordered by creation.
  ```localhost:3000/library/```
- An endpoint for a user to perform a purchase of a content.
  ```localhost:3000/users/<user_id>/purchase```
- An endpoint to get the library of a user ordered by the remaining time to watch the content (expired excluded)
  ```localhost:3000/users/<user_id>/purchases```
  
## Examples of cache working:
After run seeds cache will be calculated on background
![sidekiq running after seeds](https://i.ibb.co/CVQdQq4/sidekiq-running-after-seeds.png)

This means that requesting seasons it will look for the cache instead of make the query:
![seasons_index_search_cached_data](https://i.ibb.co/3vVCfZ4/2020-02-11-21h04-04.png)

Now will delete a season, this will trigger the backgroud job to expire ad generate new cache key to be used o new request
![delete trigger expiration and creation of cache](https://i.ibb.co/CWnMpm6/2020-02-11-21h09-16.png)
After that request seasons idex will match the new cache key with data updated without season 1
![cache key updated in background](https://i.ibb.co/7tfcPTQ/2020-02-11-21h16-23.png)
