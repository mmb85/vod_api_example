class CreatePurchasesJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    purchases = Purchase.all

    Rails.cache.delete(Purchase.cache_key(purchases))

    Rails.cache.fetch(Purchase.cache_key(purchases)) do
      purchases.to_json
    end
  end
end