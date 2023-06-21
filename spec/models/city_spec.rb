require 'rails_helper'

RSpec.describe City, type: :model do
  it 'City factory must be valid' do
    city = build(:city)
    expect(city).to be_valid
  end

  describe 'validations' do
    subject { build(:city) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:name) }
    it { should_not allow_value('San Cristobal 123').for(:name) }
  end
end
