require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a email and password' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end
end
