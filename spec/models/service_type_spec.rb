require 'rails_helper'

RSpec.describe ServiceType do
  it 'Factory must be valid' do
    service_type = build(:service_type)
    expect(service_type).to be_valid
  end

  describe 'Associations' do
    subject { build(:service_type) }

    it { is_expected.to have_many(:services) }
  end

  describe 'validations' do
    subject { build(:service_type) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to allow_value('Limpieza de Inmuebles').for(:name) }
  end
end
