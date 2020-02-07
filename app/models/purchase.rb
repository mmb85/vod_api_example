# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  season_id  :integer
#  user_id    :integer          not null
#  price      :float            not null
#  quality    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Purchase < ApplicationRecord
  belongs_to :movie, required: false
  belongs_to :season, required: false
  belongs_to :user

  enum quality: %i(SD HD)

  validates_presence_of :price, :quality

  validate :purchase_type_must_be_uniq
  validates :movie_id, presence: true,  unless: -> (purchase) { purchase.season_id.present? }
  validates_uniqueness_of :movie, scope: %i[user quality], message: 'Movie is available in your library', if: -> (purchase) { purchase.movie_id.present? }
  validates :season_id, presence: true, unless: -> (purchase) { purchase.movie_id.present? }
  validates_uniqueness_of :season, scope: %i[season quality], message: 'Season is available in your library', if: -> (purchase) { purchase.season_id.present? }

private
  def purchase_type_must_be_uniq
    if season_id && movie_id
      errors.add(:movie_id, 'season_id is present too')
      errors.add(:season_id, 'movie_id is present too')
    end
  end
end
