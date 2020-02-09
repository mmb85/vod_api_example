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
#  expired    :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Purchase, type: :model do

  describe 'associations' do
    it { should belong_to(:movie).optional }
    it { should belong_to(:season).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quality) }
  end
end
