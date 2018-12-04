require 'rails_helper'


feature 'Spot CRUD', js: true do

  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_as(user)
  end

  context 'logged in user' do
    describe 'adds new spot' do
      it {
        visit spots_path
        find('.new_spot_btn').click
        within '#new_spot' do
          fill_in 'Name', with: 'Morfa'
        end
      }
    end

    describe 'submit incomplete form' do

    end

    describe 'cancels form' do

    end

    describe 'resets form' do

    end

  end

end
