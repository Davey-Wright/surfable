require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do

  subject { FactoryBot.build(:condition_wind) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid with no direction values' do
      subject.direction = nil
      is_expected.to_not be_valid
    end

    it 'is not valid with no speed values' do
      subject.speed = nil
      is_expected.to_not be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

end
