require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do

  subject { FactoryBot.build(:condition_wind) }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }

    it 'is not valid without title' do
      subject.title = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without direction' do
      subject.direction = nil
      is_expected.to_not be_valid
    end

  end
end
