require 'rails_helper'

RSpec.describe Condition::Swell, type: :model do

  subject { FactoryBot.build(:conditions).swell }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
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

  end
end
