require 'rails_helper'

RSpec.describe User do
  it 'Factory is valid' do
    user = build(:user)
    expect(user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:ratings) }
  end

  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:phone) }

    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(50) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(50) }
    it { is_expected.to validate_length_of(:phone).is_at_least(11).is_at_most(20) }

    it { is_expected.to allow_value('John').for(:name) }
    it { is_expected.to allow_value("O'Reilly").for(:name) }
    it { is_expected.to allow_value('John Doe').for(:name) }
    it { is_expected.to allow_value('Doe').for(:last_name) }
    it { is_expected.to allow_value('+1234567890').for(:phone) }
    it { is_expected.to allow_value('123-456-7890').for(:phone) }
    it { is_expected.to allow_value('(123)456-7890').for(:phone) }
    it { is_expected.to allow_value('123 456 7890').for(:phone) }

    it { is_expected.not_to allow_value('').for(:name) }
    it { is_expected.not_to allow_value('J').for(:name) }
    it { is_expected.not_to allow_value('John@Doe').for(:name) }
    it { is_expected.not_to allow_value('D').for(:last_name) }
    it { is_expected.not_to allow_value('1234567890').for(:phone) }
    it { is_expected.not_to allow_value('12345678').for(:phone) }
    it { is_expected.not_to allow_value('ABCDEF').for(:phone) }
  end

  describe 'requiered fields' do
    it 'is invalid without email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid without role' do
      user = build(:user, role: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'Email validations' do
    it 'is invalid with a repeated email' do
      create(:user, email: 'test@email.test')
      user = build(:user, email: 'test@email.test')
      expect(user).not_to be_valid
    end

    it 'is invalid without email format' do
      user = build(:user, email: 'email.test')
      expect(user).not_to be_valid
    end
  end

  describe 'Role validations' do
    it 'is invalid if is not one of the accepted roles' do
      user = build(:user)
      user.role = 'super'
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid,
                                           'Validation failed: Role is not included in the list')
    end

    it 'is valid with one of the accepted roles (seller)' do
      user = build(:user, role: 1)
      expect(user).to be_valid
      expect(user.save).to be true
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
