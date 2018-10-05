require 'rails_helper'

RSpec.describe Condition, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:spot) { FactoryBot.create(:spot, user: user) }
  let(:session) { FactoryBot.create(:session, spot: spot) }

  subject {
    described_class.new( session: session,
      tide: {
        position: {
          basic: ['low', 'mid', 'high'],
          advanced: {
            from: 6,
            to: 12
          }
        },
        movement: ['rising', 'slack', 'dropping'],
        size: {
          basic: ['small', 'medium', 'large'],
          advanced: 12
        }
      },

      wave: {
        min_period: 10,
        direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
        min_height: 10,
        max_height: 100
      },

      wind: {
        direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
        speed: ['<5', '<10', '<15', '<20', '<30', '<40']
      }
    )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:session) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:session) }
  end

end
