require 'rails_helper'

RSpec.describe Residence, type: :model do
  it 'Zone factory must be valid' do
    res = build(:residence)
    expect(res).to be_valid
  end

  describe 'associations' do
    subject { build(:residence) }
    it { should belong_to(:zone) }
  end

  describe 'validations' do
    subject { build(:residence) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:name) }
  end
end
