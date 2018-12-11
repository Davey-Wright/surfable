require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do

  subject { FactoryBot.build(:condition_wind) }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
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

end
