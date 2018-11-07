require 'rails_helper'
require 'support/spot_session_stub'
require 'support/good_forecast_stub'

RSpec.describe SpotSession, type: :model do
  let(:spot) { FactoryBot.create(:spot) }

  subject {
    described_class.new( spot_session_stub.merge(spot: spot) )
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
    it { is_expected.to have_one(:conditions).class_name('Condition::Condition').dependent(:destroy)  }
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
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'CRUD' do
    context 'Create' do
      it 'Does not create new session with invalid attributes' do
        subject.name = nil
        expect(subject.save).to be(false)
        expect(SpotSession.all.count).to eq(0)
      end

      it 'Creates a new session with valid attributes' do
        expect(subject.save).to be(true)
        expect(SpotSession.all.count).to eq(1)
      end
    end

    context 'Update' do
      it 'Does not update session with invalid attributes' do
        subject.save
        expect(subject.update_attributes({ name: nil })).to eq(false)
        subject.reload
        expect(subject.name).to_not eq(nil)
      end

      it 'Updates session with valid attributes' do
        subject.save
        expect(subject.update_attributes({ name: 'Morfa' })).to eq(true)
        expect(subject.name).to eq('Morfa')
      end
    end

    context 'Delete' do
      it 'Deletes session from db and all child associations' do
        subject.save
        expect(subject.destroy).to be_valid
        expect(SpotSession.all.count).to eq(0)
        expect(Condition::Condition.all.count).to eq(0)
        expect(Condition::Swell.all.count).to eq(0)
        expect(Condition::Tide.all.count).to eq(0)
        expect(Condition::Wind.all.count).to eq(0)
      end
    end
  end

  describe 'Methods' do
    let(:forecast) { Forecast::Day.new good_forecast }

    context 'with a good surf forecast' do
      describe 'surfable' do
        it {  }
      end
    end

    context 'with a bad surf forecast' do
      describe 'surfable' do

      end
    end
  end

end

# first_light = 6:42
# last_light = 5:14
#
# high =  [05:06, 17:26]
# low =  [11:07, 23:32]
