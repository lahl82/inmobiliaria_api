# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:service_type) }

    it { should have_many(:requests) }
    it { should have_many(:questions) }
    it { should have_many(:ratings) }
  end

  describe 'validations' do
    subject { build(:service) }

    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(1000) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
