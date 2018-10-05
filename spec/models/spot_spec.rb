require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:user) { FactoryBot.create(:user) }

  subject {
    described_class.new(user: user, name: 'Hardies Bay',
        wave_break_type: ['beach', 'reef'],
        wave_shape: ['crumbling', 'steep'],
        wave_length: ['short', 'average'],
        wave_speed: ['average'],
        wave_direction: ['left', 'right']
      )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:sessions).dependent(:delete_all) }
    it { is_expected.to have_many(:conditions).through(:sessions) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
