class CreateMoviesJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    movies = Movie.all

    Rails.cache.delete(Movie.cache_key(movies))

    Rails.cache.fetch(Movie.cache_key(movies)) do
      movies.to_json
    end
  end
end
