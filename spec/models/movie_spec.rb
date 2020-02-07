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
  describe 'default movie details' do
    let!(:movie) { create :movie }

    it 'should initialize user with an email' do
      expect(Movie.count).to eq 1
      expect(movie.title).to eq('The Godfather')
      expect(movie.plot).to eq('The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
    end
  end
end
