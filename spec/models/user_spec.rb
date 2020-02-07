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

  describe 'associations' do
    it { should have_many(:purchases) }
    it { should have_many(:movies).through(:purchases) }
  end

  describe 'validations' do
    subject { User.new(email: 'fake@email.com') }
    it { should validate_uniqueness_of(:email) }
  end




  # TODO MOVE TO CONTROLLER SPEC
  describe 'default user details' do
    let!(:user) { create :user }

    it 'should initialize user with an email' do
      expect(User.count).to eq 1
      expect(user.email).to eq("fake@email.com")
    end
  end

  describe 'User uniquenes' do
    let!(:user) { create :user }

    context 'email should be uniq' do
      let(:user1) { User.new(email: user.email,) }

      it { expect(user1).to_not be_valid }
    end
  end
end
