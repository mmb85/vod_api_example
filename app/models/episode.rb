# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  season_id  :integer          not null
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Episode < ApplicationRecord
  belongs_to :season, touch: true

  validates_presence_of :title, :number, :season
  validates_uniqueness_of :number, scope: :season_id
  validates_uniqueness_of :title, scope: :season_id


  after_commit :create_json_cache

  def self.cache_key(episodes)
    {
      serializer: 'episodes',
      stat_record: Episode.maximum(:updated_at)
    }
  end

  private

  def create_json_cache
    CreateEpisodesJsonCacheJob.perform_later
  end
end
