require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:spot) { FactoryBot.create(:spot, user: user ) }

  subject {
    described_class.new( spot: spot,
      name: 'Longboard greasing',
      conditions_attributes: {
        tide: {},
        wind: {},
        wave: {}
      })
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:spot) }
    it { is_expected.to have_one(:conditions).class_name('Condition') }
    it { is_expected.to accept_nested_attributes_for :conditions}
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
