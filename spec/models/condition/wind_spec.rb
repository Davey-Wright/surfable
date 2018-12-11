require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do

  subject { Condition::Wind.create({
      spot: FactoryBot.create(:spot),
      rating: 3,
      name: ['onshore'],
      direction: ['n', 'ne', 'e'],
      speed: 20
    })
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid with no direction' do
      subject.direction = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no speed' do
      subject.speed = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no rating' do
      subject.rating = nil
      is_expected.to_not be_valid
    end
  end

  describe 'Testing' do
    it 'is expected to have a valid factory' do
      expect(FactoryBot.build(:wind_conditions)).to be_valid
    end
  end

end
