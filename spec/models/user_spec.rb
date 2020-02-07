# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'default user details' do
    let!(:user) { create :user }

    it 'should initialize user with an email' do
      expect(User.count).to eq 1
      expect(user.email).to eq("fake@email.com")
    end
  end
end
