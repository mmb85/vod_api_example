require 'rails_helper'

RSpec.describe Purchase, type: :model do

  describe 'associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:season) }
    it { should have_many(:user).through(:purchases) }
  end

  describe 'validations' do
    #subject { Purchase.new(email: 'fake@email.com') }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quality) }
  end
end


#  validates_presence_of :price, :quality

#  validate :purchase_type_must_be_uniq
#  validates :movie_id, presence: true,  unless: -> (purchase) { purchase.season_id.present? }
#  validates_uniqueness_of :movie, scope: %i[user quality], message: 'Movie is available in your library', if: -> (purchase) { purchase.movie_id.present? }
#  validates :season_id, presence: true, unless: -> (purchase) { purchase.movie_id.present? }
#  validates_uniqueness_of :season, scope: %i[season quality], message: 'Season is available in your library', if: -> (purchase) { purchase.season_id.present? }
