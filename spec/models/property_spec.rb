require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it { should belong_to(:agent) }
  end

  describe 'validations' do
    subject { build(:property) }

    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(1000) }
    it { should validate_presence_of(:direction) }
    it { should validate_length_of(:direction).is_at_most(255) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_bedroom).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_bathroom).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_floor).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_kitchen).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_parking).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:qty_hall).only_integer.is_greater_than_or_equal_to(0) }

    describe 'conditional validations' do
      context 'when type is house' do
        subject { build(:property, :type_house) }

        it 'should be valid with all the required attributes' do
          expect(subject).to be_valid
        end

        it 'should not be valid if one attribute is missing' do
          new_property = subject
          new_property.yard = nil
          expect(new_property).to_not be_valid
        end
      end

      context 'when type is apartment or annex' do
        subject { build(:property, :type_apartament_or_annex) }
        it 'should be valid with all the required attributes' do
          expect(subject).to be_valid
        end

        it 'should not be valid if one attribute is missing' do
          new_property = subject
          new_property.social = nil
          expect(new_property).to_not be_valid
        end
      end

      context 'when type is shop' do
        subject { build(:property, :type_shop) }
        it 'should be valid with all the required attributes' do
          expect(subject).to be_valid
        end

        it 'should not be valid if one attribute is missing' do
          new_property = subject
          new_property.qty_floor = nil
          expect(new_property).to_not be_valid
        end
      end

      context 'when type is shed' do
        subject { build(:property, :type_shed) }
        it 'should be valid with all the required attributes' do
          expect(subject).to be_valid
        end

        it 'should not be valid if one attribute is missing' do
          new_property = subject
          new_property.office = nil
          expect(new_property).to_not be_valid
        end
      end
    end
  end
end
