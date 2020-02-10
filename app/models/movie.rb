# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Movie < ApplicationRecord
  has_many :purchases
  has_many :users, through: :purchases

  validates_uniqueness_of :title
  validates_presence_of :title

  after_commit :create_json_cache

  def self.cache_key(movies)
    {
      serializer: 'movies',
      stat_record: movies.maximum(:updated_at)
    }
  end

  private

  def create_json_cache
    CreateMoviesJsonCacheJob.perform_later
  end
end