require 'rails_helper'

RSpec.describe Condition::Swell, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  subject {
    described_class.new( condition: condition,
      min_height: 3,
      max_height: 15,
      min_period: 9,
      direction: ['w', 'sw', 's']
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
