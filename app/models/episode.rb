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
  belongs_to :season

  validates_presence_of :title, :number, :season
  #validate :uniq_per_season

private
  def uniq_per_season
    if self.class.where(title: self.title, season_id: self.season_id) > 0
      errors.add(:title, 'Title episode must be unique per Season')
    end
  end
end
