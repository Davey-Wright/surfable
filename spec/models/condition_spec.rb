require 'rails_helper'

RSpec.describe Condition::Condition, type: :model do

  subject { FactoryBot.build(:conditions) }
  it { binding.pry }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
    it { is_expected.to have_one(:swell).dependent(:destroy) }
    it { is_expected.to have_one(:tide).dependent(:destroy) }
    it { is_expected.to have_many(:winds).dependent(:delete_all) }
    it { is_expected.to accept_nested_attributes_for(:swell) }
    it { is_expected.to accept_nested_attributes_for(:tide) }
    it { is_expected.to accept_nested_attributes_for(:winds) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    it 'is not valid without swell' do
      subject.swell = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without tide' do
      subject.tide = nil
      is_expected.to_not be_valid
    end

    it 'is not valid without wind' do
      subject.winds = nil
      is_expected.to_not be_valid
    end

    it 'should validate swell' do
      subject.swell.min_period = nil
      is_expected.to_not be_valid
    end

    # it 'should validate wind' do
    #   subject.wind.speed = nil
    #   is_expected.to_not be_valid
    # end

    it 'should validate tide' do
      subject.tide.size = nil
      is_expected.to_not be_valid
    end
  end

  describe 'CRUD' do
    context 'Delete' do
      it 'Deletes session from db and all child associations' do
        subject.save
        expect(subject.destroy).to be_valid
        expect(Condition::Condition.all.count).to eq(0)
        expect(Condition::Swell.all.count).to eq(0)
        expect(Condition::Tide.all.count).to eq(0)
        expect(Condition::Wind.all.count).to eq(0)
      end
    end
  end
end
