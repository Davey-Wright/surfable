require 'rails_helper'
require 'support/spot_stub'

RSpec.describe Spot, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject {
    described_class.new({
      user: user,
      name: 'Hardies Bay',
      wave_break_type: 'beach',
      wave_shape: ['crumbling', 'steep'],
      wave_length: ['short', 'average'],
      wave_speed: ['slow', 'average'],
      wave_direction: ['left', 'right']
    }) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:spot_sessions).dependent(:destroy) }
    it { is_expected.to have_many(:conditions).through(:spot_sessions) }
    it { is_expected.to accept_nested_attributes_for(:spot_sessions) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should validate spot sessions' do
      subject.spot_sessions = [FactoryBot.build(:spot_session, name: nil)]
      expect(subject.valid?).to be(false)
    end
  end

  describe 'CRUD' do
    context 'Create' do
      it 'Does not create new spot with invalid attributes' do
        subject.name = nil
        expect(subject.save).to be(false)
        expect(Spot.all.count).to eq(0)
      end

      it 'Does not create spot with invalid session attributes' do
        subject.spot_sessions = [FactoryBot.build(:spot_session, name: nil)]
        expect(subject.save).to be(false)
        expect(Spot.all.count).to eq(0)
      end

      it 'Creates a new spot with valid attributes' do
        expect(subject.save).to be(true)
        expect(Spot.all.count).to eq(1)
      end
    end

    context 'Update' do
      it 'Does not update spot with invalid attributes' do
        subject.save
        expect(subject.update_attributes({ name: nil })).to eq(false)
        subject.reload
        expect(subject.name).to_not eq(nil)
      end

      it 'Updates spot with valid attributes' do
        subject.save
        expect(subject.update_attributes({ name: 'Morfa' })).to eq(true)
        expect(subject.name).to eq('Morfa')
      end
    end

    context 'Delete' do
      it 'Deletes all child associations' do
        subject.save
        expect(subject.destroy).to be_valid
        expect(Spot.all.count).to eq(0)
        expect(SpotSession.all.count).to eq(0)
        expect(Condition::Condition.all.count).to eq(0)
        expect(Condition::Swell.all.count).to eq(0)
        expect(Condition::Tide.all.count).to eq(0)
        expect(Condition::Wind.all.count).to eq(0)
      end
    end
  end

end
