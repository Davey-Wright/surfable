require 'rails_helper'

RSpec.describe Condition::Tide, type: :model do

  subject { FactoryBot.build(:conditions).tide }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
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
end
