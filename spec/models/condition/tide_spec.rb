require 'rails_helper'

RSpec.describe Condition::Tide, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  subject {
    described_class.new( condition: condition,
      position_low_high: [2, 0],
      position_high_low: [3, 0],
      size: ['small', 'average', 'large']
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
