# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request do
  describe 'validations' do
    subject { build(:request) }

    it { is_expected.to validate_presence_of(:date) }

    it 'validates the format of date' do
      request = build(:request, date: 'hoy') # Invalid format
      expect(request).not_to be_valid
    end

    it 'validates the inclusion of date within a range' do
      request = build(:request, date: Time.zone.now)

      expect(request).not_to be_valid
      expect(request.errors[:date]).to include('should be within the next 30 days')

      request.date = 15.days.from_now
      expect(request).to be_valid

      request.date = 1.day.ago # Outside the range
      expect(request).not_to be_valid

      request.date = 35.days.from_now # Outside the range
      expect(request).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:service) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      request = build(:request)
      expect(request).to be_valid
    end
  end
end
