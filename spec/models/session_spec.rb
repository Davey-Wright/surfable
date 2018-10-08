require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:spot) { FactoryBot.create(:spot) }
  let(:swell) { FactoryBot.create(:swell) }

  subject {
    described_class.new( spot: spot,
      name: 'Longboard greasing',
      conditions_attributes: {
        swell_attributes: {
          min_height: 3,
          max_height: 15,
          min_period: 9,
          direction: ['w', 'sw', 's']
        },
        tide_attributes: {
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
        },
        wind_attributes: {
          direction: ['n', 'nw', 'w'],
          speed: 10
        }
      }
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
    it { is_expected.to have_one(:conditions).class_name('Condition::Condition').dependent(:delete)  }
    it { is_expected.to accept_nested_attributes_for(:conditions) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:spot) }
  end

end
