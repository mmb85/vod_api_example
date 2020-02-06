require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'default user details' do
    let(:user) { create :user }

    it 'should initialize user with an email' do
      expect(user.email).to eq("fake@email.com")
    end
  end

  describe 'default user details' do
    before do
      create :user
    end

    it 'should initialize user with name and age' do
      expect(User.count).to eq 1

      u = User.last
      debugger

      expect(u.email).to eq("fake@email.com")
    end
  end
end