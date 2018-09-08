require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create new user' do
    context 'with missing required properties' do
      it 'should not add user to db' do
        User.create(first_name: '', last_name: '', email: '', password: '')
        expect(User.count).to eq(0)
      end
    end

    context 'with all required properties' do
      it 'should add user to db' do
        user = FactoryBot.create(:user)
        expect(User.count).to eq(1)
      end
    end
  end

  describe 'update user' do
    context 'with missing required properties' do
      it 'should not add user to db' do
        @user = FactoryBot.create(:user)
      end
    end

    context 'with all required properties' do
      it 'should add user to db' do

      end
    end
  end

  describe 'delete user' do
    context 'should remove user from db' do
      user = FactoryBot.create(:user)
    end
  end

end
