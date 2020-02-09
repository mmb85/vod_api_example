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

require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'associations' do
    it { should have_many(:purchases) }
    it { should have_many(:users).through(:purchases) }
    it { should have_many(:episodes).dependent(:destroy) }
  end

  describe 'validations' do
    subject { Season.new(title: 'Gotham', plot: "As a child in Gotham City, Bruce Wayne falls down a dry well and is attacked by a swarm of bats, developing a fear of bats. Attending the opera with his parents, Thomas and Martha, Bruce becomes frightened by performers masquerading as bats and asks to leave. Outside, mugger Joe Chill murders Bruce's parents in front of him, and the orphaned Bruce is raised by the family butler, Alfred Pennyworth.") }
    it { should validate_presence_of(:title) }
  end
end
