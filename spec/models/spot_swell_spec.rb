require 'rails_helper'

RSpec.describe Condition::Swell, type: :model do
  subject do
    Condition::Swell.create(
      spot: FactoryBot.create(:spot),
      rating: 3,
      min_height: 5,
      max_height: nil,
      min_period: 10,
      direction: %w[w sw s]
    )
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid without min_height' do
      subject.min_height = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without min_period' do
      subject.min_period = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without a rating' do
      subject.rating = nil
      is_expected.to_not be_valid
    end

    it 'does not store empty values in attributes which are collections' do
      subject.direction = ['']
      subject.save
      expect(subject.direction.count).to eq(0)
    end
  end

  describe 'Testing' do
    it 'should have a valid factory' do
      expect(FactoryBot.build(:swell_conditions)).to be_valid
    end
  end
end
