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

require 'rails_helper'

RSpec.describe Episode, type: :model do

  describe 'associations' do
    it { should belong_to(:season).class_name('Season') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:season) }
  end

  describe 'default episode details' do
    let!(:episode) { create :episode }

    it 'should initialize episode with valid params' do
      expect(Episode.count).to eq 1
    end
  end
end
