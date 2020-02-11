class CreateUsersJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    users = User.includes(:purchases)

    Rails.cache.delete(User.cache_key(users))

    Rails.cache.fetch(User.cache_key(users)) do
      users.to_json(include: :purchases)
    end
  end
end