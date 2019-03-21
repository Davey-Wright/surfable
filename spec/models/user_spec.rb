require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      first_name: 'Demo',
      last_name: 'Surfable',
      email: 'demo@surfable.com',
      password: 'demosender'
    )
  end

  describe 'Associations' do
    it { is_expected.to have_many(:spots).dependent(:delete_all) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'CRUD' do
    context 'Create' do
      it 'Does not create new spot when invalid' do
        subject.first_name = nil
        expect(subject.save).to be(false)
        expect(User.all.count).to eq(0)
      end

      it 'Creates a new spot when valid' do
        expect(subject.save).to be(true)
        expect(User.all.count).to eq(1)
      end
    end

    context 'Update' do
      it 'Does not update spot when invalid' do
        subject.save
        expect(subject.update_attributes(first_name: nil)).to eq(false)
        subject.reload
        expect(subject.first_name).to_not eq(nil)
      end

      it 'Updates spot when valid' do
        subject.save
        expect(subject.update_attributes(first_name: 'Melaka')).to eq(true)
        expect(subject.first_name).to eq('Melaka')
      end
    end

    context 'Delete' do
      it 'Deletes all child associations' do
        subject.save
        subject.destroy
        expect(User.all.count).to eq(0)
        expect(Spot.all.count).to eq(0)
      end
    end
  end
end
