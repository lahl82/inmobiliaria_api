require 'rails_helper'

RSpec.describe Zone, type: :model do
  it 'Zone factory must be valid' do
    zone = build(:zone)
    expect(zone).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:city) }
    # it { should have_many(:zones) }
  end

  describe 'validations' do
    subject { build(:zone) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:name) }
  end
end
