require 'rails_helper'
require 'support/spot_stub'

RSpec.describe Spot, type: :model do
  let(:user) { FactoryBot.create(:user) }

  subject {
    described_class.new(spot_stub.merge(user: user))
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
    it { is_expected.to have_many(:conditions).through(:sessions) }
    it { is_expected.to accept_nested_attributes_for(:sessions) }
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

    it 'is not valid without a session name' do
      subject.sessions.first.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'CRUD' do
    it 'Does not create new spot with invalid attributes' do
      subject.name = nil
      expect(subject.save).to be(false)
      expect(Spot.all.count).to eq(0)
    end

    it 'Does not create spot with invalid session attributes' do
      subject.sessions.first.name = nil
      expect(subject.save).to be(false)
      expect(Spot.all.count).to eq(0)
    end

    it 'Creates a new spot with valid attributes' do
      expect(subject.save).to be(true)
      expect(Spot.all.count).to eq(1)
    end

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

    it 'Deletes spot from db and all child associations' do
      subject.save
      expect(subject.destroy).to be_valid
      expect(Spot.all.count).to eq(0)
      expect(Session.all.count).to eq(0)
      expect(Condition::Condition.all.count).to eq(0)
      expect(Condition::Swell.all.count).to eq(0)
      expect(Condition::Tide.all.count).to eq(0)
      expect(Condition::Wind.all.count).to eq(0)
    end
  end

end
