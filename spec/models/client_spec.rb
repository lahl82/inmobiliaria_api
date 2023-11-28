require 'rails_helper'

RSpec.describe Agent, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:properties) }
  end

  describe 'validations' do
    subject(:agent) { FactoryBot.build(:agent) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:agency) }

    it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_least(2).is_at_most(50) }
    it { should validate_length_of(:phone).is_at_least(11).is_at_most(20) }

    it { should allow_value('John').for(:name) }
    it { should allow_value("O'Reilly").for(:name) }
    it { should allow_value('John Doe').for(:name) }
    it { should allow_value('Doe').for(:last_name) }
    it { should allow_value('+1234567890').for(:phone) }
    it { should allow_value('123-456-7890').for(:phone) }
    it { should allow_value('(123)456-7890').for(:phone) }
    it { should allow_value('123 456 7890').for(:phone) }

    it { should_not allow_value('').for(:name) }
    it { should_not allow_value('J').for(:name) }
    it { should_not allow_value('John@Doe').for(:name) }
    it { should_not allow_value('D').for(:last_name) }
    it { should_not allow_value('1234567890').for(:phone) }
    it { should_not allow_value('12345678').for(:phone) }
    it { should_not allow_value('ABCDEF').for(:phone) }

    it 'validates uniqueness of name and last_name' do
      FactoryBot.create(:agent, name: 'John', last_name: 'Doe')
      agent = FactoryBot.build(:agent, name: 'John', last_name: 'Doe')
      expect(agent).to be_invalid
      expect(agent.errors[:base]).to include('Name and last name combination must be unique')
    end
  end
end
