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
      end

      context 'when type is apartment or annex' do
        subject { build(:property, :type_apartament_or_annex) }
        it 'should be valid with all the required attributes' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when type is house' do
      before { subject.property_type = :house }
      before { subject.is_private = nil }

      it { should validate_inclusion_of(:is_private).in_array([true, false]) }
      it { should validate_presence_of(:qty_bathroom) }
      it { should validate_presence_of(:qty_bedroom) }
      it { should validate_presence_of(:qty_parking) }
      it { should validate_presence_of(:qty_floor) }
      it { should validate_presence_of(:qty_kitchen) }
      it { should validate_presence_of(:qty_hall) }
      it { should validate_presence_of(:office) }
      it { should validate_presence_of(:shop) }
      it { should validate_presence_of(:yard) }
      it { should validate_presence_of(:garden) }
      it { should validate_presence_of(:social) }
      it { should validate_presence_of(:area) }
      it { should validate_presence_of(:mode) }
    end

    context 'when type is apartment' do
      before { subject.property_type = :apartment }
      it { should validate_presence_of(:is_private) }
      it { should validate_presence_of(:qty_bathroom) }
      it { should validate_presence_of(:qty_bedroom) }
      it { should validate_presence_of(:qty_parking) }
      it { should validate_presence_of(:area) }
      it { should validate_presence_of(:mode) }
      it { should validate_presence_of(:social) }
    end

    context 'when type is annex' do
      before { subject.property_type = :annex }
      it { should validate_presence_of(:is_private) }
      it { should validate_presence_of(:qty_bathroom) }
      it { should validate_presence_of(:qty_bedroom) }
      it { should validate_presence_of(:qty_parking) }
      it { should validate_presence_of(:area) }
      it { should validate_presence_of(:mode) }
    end

    context 'when type is shop' do
      before { subject.property_type = :shop }
      it { should validate_presence_of(:is_private) }
      it { should validate_presence_of(:qty_bathroom) }
      it { should validate_presence_of(:qty_floor) }
      it { should validate_presence_of(:area) }
      it { should validate_presence_of(:office) }
      it { should validate_presence_of(:mode) }
    end

    context 'when type is shed' do
      before { subject.property_type = :shed }
      it { should validate_presence_of(:is_private) }
      it { should validate_presence_of(:qty_bathroom) }
      it { should validate_presence_of(:qty_floor) }
      it { should validate_presence_of(:area) }
      it { should validate_presence_of(:office) }
      it { should validate_presence_of(:shop) }
      it { should validate_presence_of(:qty_bedroom) }
      it { should validate_presence_of(:yard) }
      it { should validate_presence_of(:mode) }
    end
  end
end
