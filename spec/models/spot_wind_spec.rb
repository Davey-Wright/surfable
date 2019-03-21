require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do
  subject do
    Condition::Wind.create(
      spot: FactoryBot.create(:spot),
      rating: 3,
      name: ['onshore'],
      direction: %w[n ne e],
      max_speed: 20
    )
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid with no direction' do
      subject.direction = ['']
      is_expected.to_not be_valid
    end

    it 'is not valid with no speed' do
      subject.max_speed = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no rating' do
      subject.rating = nil
      is_expected.to_not be_valid
    end

    it 'does not store empty values in attributes which are collections' do
      subject.name = ['']
      subject.direction = ['']
      subject.save
      expect(subject.direction.count).to eq(0)
      expect(subject.name.count).to eq(0)
    end
  end

  describe 'Testing' do
    it 'is expected to have a valid factory' do
      expect(FactoryBot.build(:wind_conditions)).to be_valid
    end
  end
end
