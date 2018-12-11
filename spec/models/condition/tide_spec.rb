require 'rails_helper'

RSpec.describe Condition::Tide, type: :model do

  subject { Condition::Tide.create({
      spot: FactoryBot.create(:spot),
      rating: 3,
      rising: [1, 2, 3],
      dropping: [1, 2, 3],
      size: ['all']
    })
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid with no rising offset' do
      subject.dropping = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no rising offset' do
      subject.rising = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no rating' do
      subject.rating = nil
      is_expected.to_not be_valid
    end
  end

  describe 'Testing' do
    it 'is expected to have a valid factory' do
      expect(FactoryBot.build(:tide_conditions)).to be_valid
    end
  end
end
