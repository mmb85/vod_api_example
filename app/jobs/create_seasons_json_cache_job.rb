class CreateSeasonsJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    seasons = Season.includes(:episodes)

    Rails.cache.delete(Season.cache_key(seasons))

    Rails.cache.fetch(Season.cache_key(seasons)) do
      seasons.to_json(include: :episodes)
    end
  end
end