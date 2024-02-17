# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:service_type) }

    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:ratings) }
  end

  describe 'validations' do
    subject { build(:service) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
