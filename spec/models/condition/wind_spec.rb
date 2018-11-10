require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  subject { FactoryBot.build(:conditions_wind)}

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
