# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request do
  describe 'validations' do
    subject { build(:rating) }

    it { is_expected.to validate_presence_of(:description) }

    it 'validates the description not to be empty' do
      rating = build(:rating, description: '')
      expect(rating).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:service) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      rating = build(:rating)
      expect(rating).to be_valid
    end
  end
end
