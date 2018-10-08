require 'rails_helper'

RSpec.describe Condition::Wind, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  subject {
    described_class.new( condition: condition,
      direction: ['n', 'nw', 'w'],
      speed: 10
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
