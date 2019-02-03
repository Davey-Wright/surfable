require 'rails_helper'

# Test that
#   Non authenticated users cannot create spots and are redirected to login page
#   Form displays attribute fields
#   Form displays necessary validations
#   Form resets without submiting
#   Spot can be created with minimal requirements
#   All form attributes are valid and can be saved
#   Spot page displays spots contents

feature 'User submits new Spot', js: true do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do |test|
    login user unless test.metadata[:logged_out]
    @scoped_form = '#new_spot'
  end

  context 'unsuccessfully' do
    scenario 'when visitor is not registered or logged in', :logged_out do
      visit spots_path
      expect(page).to have_content(/You need to sign in or sign up before continuing./i)
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'when user leaves name blank and submits form' do
      within @scoped_form do
        click_on('Create Spot')
      end
      expect(page).to have_content(/please review the problems below:/i)
      expect(page).to have_content(/name can't be blank/i)
    end

    scenario 'when user resets the form' do
      within @scoped_form do
        fill_in 'Name', with: 'Reset this Name'
        click_on('Reset')
      end
      expect(page).to_not have_content(/reset this name/i)
      expect(find_field('Name').value).to eq('')
    end
  end

  context 'successfully' do
    scenario 'when user fills in only the name field and submits form' do
      within @scoped_form do
        fill_in 'Name', with: 'Hardies'
        click_on 'Create Spot', exact: true
      end
      expect(page).to have_content(/Hardies was successfully added to your spots/i)
      scoped_node = page.find('.spot_info')
      expect(scoped_node).to have_content(/hardies/i)
    end

    scenario 'when user fills in all fields and submits form' do
      within @scoped_form do
        fill_in 'Name', with: 'Hardies'
        find(:css, '#spot_latitude').set(10)
        find(:css, '#spot_longitude').set(10)
        find('label', text: 'Beach').click
        find('label', text: 'Point').click
        find('label', text: 'Left').click
        find('label', text: 'Short').click
        find('label', text: 'Crumbling').click
        find('label', text: 'Slow').click
        click_on('Create Spot')
      end
      expect(page).to have_content(/Hardies was successfully added to your spots/i)
      scoped_node = page.find('.spot_info')
      expect(scoped_node).to have_content(/hardies/i)
      expect(scoped_node).to have_content(/beach/i, /point/i)
      expect(scoped_node).to have_content(/crumbling/i)
      expect(scoped_node).to have_content(/short/i)
      expect(scoped_node).to have_content(/slow/i)
      expect(scoped_node).to have_content(/left/i)
      expect(page).to have_css('ul.accordion', visible: true)
    end
  end

  def login(user)
    login_as(user)
    visit spots_path
    click_on('Add new spot')
  end
end
