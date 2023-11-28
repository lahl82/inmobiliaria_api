require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Factory is valid' do
    user = build(:user)
    expect(user).to be_valid
  end

  describe 'requiered fields' do
    it 'is invalid without email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without role' do
      user = build(:user, role: nil)
      expect(user).to_not be_valid
    end
  end

  describe 'Email validations' do
    it 'is invalid with a repeated email' do
      create(:user, email: 'test@email.test')
      user = build(:user, email: 'test@email.test')
      expect(user).to_not be_valid
    end

    it 'is invalid without email format' do
      user = build(:user, email: 'email.test')
      expect(user).to_not be_valid
    end
  end

  describe 'Role validations' do
    it 'is invalid if is not one of the accepted roles and is not a symbol of th enum
    (client, agent, admin)' do
      user = build(:user)
      expect { user.role = 'super' }.to raise_error(ArgumentError, "'super' is not a valid role")
    end

    it 'is valid with one of the accepted roles (agent)' do
      user = build(:user, role: 1)
      expect(user.save).to be true
      expect(user).to be_valid
    end
  end

  describe 'Password Validations' do
    it 'is valid with a password within the length range' do
      user = build(:user, password: 'password123', password_confirmation: 'password123')
      expect(user).to be_valid
    end

    it 'is invalid with a password that is too short' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
    end

    it 'is invalid with a password that is too long' do
      user = build(:user, password: 'a' * 73, password_confirmation: 'a' * 73)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too long (maximum is 72 characters)')
    end

    it 'is invalid when password and confirmation do not match' do
      user = build(:user, password: 'password123', password_confirmation: 'password456')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
