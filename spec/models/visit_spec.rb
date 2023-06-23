require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }

    it 'validates the format of date' do
      visit = build(:visit, date: '22/06/2023') # Invalid format
      expect(visit).not_to be_valid
    end

    it 'validates the inclusion of date within a range' do
      visit = build(:visit, date: Date.current + 15.days)
      expect(visit).to be_valid

      visit.date = Date.current - 1.day # Outside the range
      expect(visit).not_to be_valid

      visit.date = Date.current + 35.day # Outside the range
      expect(visit).not_to be_valid
    end

    it 'validates that the date is a future date' do
      visit = build(:visit, date: Date.current + 1.day)
      expect(visit).to be_valid

      visit.date = Date.current
      expect(visit).not_to be_valid
      expect(visit.errors[:date]).to include('should be a future date')
    end
  end

  describe 'associations' do
    it { should belong_to(:client) }
    it { should belong_to(:property) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      visit = build(:visit)
      expect(visit).to be_valid
    end
  end
end
