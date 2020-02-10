class CreateEpisodesJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    episodes = Episode.all

    Rails.cache.delete(Episode.cache_key(episodes))

    Rails.cache.fetch(Episode.cache_key(episodes)) do
      episodes.to_json
    end
  end
end