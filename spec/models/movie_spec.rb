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

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:purchases) }
    it { should have_many(:users).through(:purchases) }
  end

  describe 'validations' do
    subject { Movie.new(title: 'Batman', plot: "As a child in Gotham City, Bruce Wayne falls down a dry well and is attacked by a swarm of bats, developing a fear of bats. Attending the opera with his parents, Thomas and Martha, Bruce becomes frightened by performers masquerading as bats and asks to leave. Outside, mugger Joe Chill murders Bruce's parents in front of him, and the orphaned Bruce is raised by the family butler, Alfred Pennyworth.") }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:title) }
  end






  describe 'default movie details' do
    let!(:movie) { create :movie }

    it 'should initialize user with an email' do
      expect(Movie.count).to eq 1
      expect(movie.title).to eq('The Godfather')
      expect(movie.plot).to eq('The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
    end
  end
end
