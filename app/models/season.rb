# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string
#  plot       :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Season < ApplicationRecord
  has_many :purchases
  has_many :users, through: :purchases
  has_many :episodes, ->{ order(number: :asc) }, dependent: :destroy
  
  validates_presence_of :title
  validates_presence_of :number

  after_commit :create_json_cache

  def self.cache_key(seasons)
    {
      serializer: 'seasons',
      stat_record: seasons.maximum(:updated_at)
    }
  end

  private

  def create_json_cache
    CreateSeasonsJsonCacheJob.perform_later
  end
end
