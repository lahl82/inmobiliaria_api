# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'validations' do
    subject { build(:question) }

    it { should validate_presence_of(:description) }

    it 'validates the description not to be empty' do
      question = build(:question, description: '')
      expect(question).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:service) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      question = build(:question)
      expect(question).to be_valid
    end
  end
end
