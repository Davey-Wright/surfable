require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe SpotSession, type: :model do

  let(:conditions) { FactoryBot.build(:conditions) }

  subject {
    FactoryBot.build(:spot_session, conditions: conditions)
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
    it { is_expected.to have_one(:conditions).class_name('Condition::Condition').dependent(:destroy)  }
    it { is_expected.to accept_nested_attributes_for(:conditions) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without conditions' do
      subject.conditions = nil
      is_expected.to_not be_valid
    end

    it 'should validate conditions' do
      subject.conditions.swell = nil
      is_expected.to_not be_valid
    end
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
    let(:forecast) { Forecast::Day.new day_forecast_stub }

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
