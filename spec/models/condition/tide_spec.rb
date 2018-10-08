require 'rails_helper'

RSpec.describe Condition::Tide, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  subject {
    described_class.new( condition: condition,
      position: {
        min: 5,
        max: 12,
        basic: ['low', 'mid', 'high']
      },
      movement: ['rising', 'slack', 'dropping'],
      size: {
        min: 10,
        max: 12,
        basic: ['small', 'medium', 'large']
      }
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
