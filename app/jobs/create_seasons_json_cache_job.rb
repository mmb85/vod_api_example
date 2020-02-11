class CreateSeasonsJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    seasons = Season.all.order(created_at: :desc).includes(:episodes)

    Rails.cache.delete(Season.cache_key(seasons))

    Rails.cache.fetch(Season.cache_key(seasons)) do
      seasons.to_json(include: :episodes)
    end
  end
end