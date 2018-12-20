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

    it 'is valid with no dropping offset' do
      subject.dropping = ['']
      is_expected.to be_valid
    end

    it 'is valid with no rising offset' do
      subject.rising = ['']
      is_expected.to be_valid
    end

    it 'is not valid with no rating' do
      subject.rating = ['']
      is_expected.to_not be_valid
    end

    it 'does not store empty values in attributes which are collections' do
      subject.rising = ['']
      subject.dropping = ['']
      subject.size = ['']

      subject.save
      expect(subject.rising.count).to eq(0)
      expect(subject.dropping.count).to eq(0)
      expect(subject.size.count).to eq(0)
    end
  end

  describe 'Testing' do
    it 'is expected to have a valid factory' do
      expect(FactoryBot.build(:tide_conditions)).to be_valid
    end
  end
end
