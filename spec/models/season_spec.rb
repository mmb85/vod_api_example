# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  number     :integer          not null
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
end
