require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do
  subject { FactoryBot.build(:conditions).winds }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
