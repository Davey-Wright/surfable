require 'rails_helper'

RSpec.describe Condition::Tide, type: :model do

  let(:condition) { FactoryBot.build(:condition) }

  subject { described_class.new({
    condition: condition,
    position_low_high: nil,
    position_high_low: nil,
    size: ['all']
  }) }

  describe 'Associations' do
    it { is_expected.to belong_to(:condition) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'sets a default position_low_high before validations' do
      subject.valid?
      expect(subject.position_low_high).to eq([0, 0])
      expect(subject.position_high_low).to eq([0, 0])
    end

    it 'is not valid without direction' do
      subject.size = nil
      is_expected.to_not be_valid
    end
  end

  describe 'CRUD' do
    context 'create' do
      it 'can set default position_low_high attribute' do
        subject.position_low_high = [1, 2]
        expect(subject.valid?).to eq(true)
        expect(subject.position_low_high).to eq([1, 2])
      end

      it 'can set default position_low_high attribute' do
        subject.position_high_low = [1, 2]
        expect(subject.valid?).to eq(true)
        expect(subject.position_high_low).to eq([1, 2])
      end
    end
  end
end
