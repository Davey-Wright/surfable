require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject do
    described_class.new(
      user: user,
      name: 'Hardies Bay',
      wave_break_type: 'beach',
      wave_shape: %w[crumbling steep],
      wave_length: %w[short average],
      wave_speed: %w[slow average],
      wave_direction: %w[left right]
    )
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:swells).dependent(:delete_all) }
    it { is_expected.to have_many(:winds).dependent(:delete_all) }
    it { is_expected.to have_one(:tide).dependent(:delete) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'does not store empty values in attributes which are collections' do
      subject.wave_shape = ['']
      subject.wave_length = ['']
      subject.wave_speed = ['']
      subject.wave_direction = ['']

      subject.save
      expect(subject.wave_shape.count).to eq(0)
      expect(subject.wave_length.count).to eq(0)
      expect(subject.wave_speed.count).to eq(0)
      expect(subject.wave_direction.count).to eq(0)
    end
  end

  describe 'CRUD' do
    context 'Create' do
      it 'Does not create new spot when invalid' do
        subject.name = nil
        expect(subject.save).to be(false)
        expect(Spot.all.count).to eq(0)
      end

      it 'Creates a new spot when valid' do
        expect(subject.save).to be(true)
        expect(Spot.all.count).to eq(1)
      end
    end

    context 'Update' do
      it 'Does not update spot when invalid' do
        subject.save
        expect(subject.update_attributes(name: nil)).to eq(false)
        subject.reload
        expect(subject.name).to_not eq(nil)
      end

      it 'Updates spot when valid' do
        subject.save
        expect(subject.update_attributes(name: 'Morfa')).to eq(true)
        expect(subject.name).to eq('Morfa')
      end
    end

    context 'Delete' do
      it 'Deletes all child associations' do
        subject.save
        subject.destroy
        expect(Spot.all.count).to eq(0)
        expect(Condition::Swell.all.count).to eq(0)
        expect(Condition::Tide.all.count).to eq(0)
        expect(Condition::Wind.all.count).to eq(0)
      end
    end
  end
end
