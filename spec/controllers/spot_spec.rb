require 'rails_helper'

RSpec.describe SpotsController, type: :controller do

  let!(:user) { FactoryBot.create(:user) }
  let!(:spot) { FactoryBot.create(:spot, user: user) }

  context 'GET #index' do
    it 'Should redirect unauthenticated user to login page' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should not display spots to other users' do
      user2 = FactoryBot.create(:user)
      new_spot = FactoryBot.create(:spot, { name: 'Nash point', user: user2 })
      sign_in user
      get :index
      shaka = assigns(:spots)
      spots = assigns(:spots)
      expect(spots.count).to eq(1)
      expect(spots.first.user).to eq(user)
    end

    it 'Should successfully display the page' do
      sign_in user
      get :index
      expect(response).to be_successful
      expect(response).to render_template :index
    end
  end

  context 'GET #new' do
    it 'Should redirect unauthenticated user to login page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should successfully display the page' do
      sign_in user
      get :new
      expect(response).to be_successful
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it 'Should redirect unauthenticated user to login page' do
      post :create
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should render validation errors' do
      sign_in user
      spot_count = user.spots.count
      post :create, params: { spot: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(user.spots.count).to eq(spot_count)
    end

    it 'Should successfully create a spot and store it in our database' do
      sign_in user
      spot_count = user.spots.count
      post :create, params: { spot: {
        name: 'Hardies Bay',
        wave_break_type: ['beach', 'reef'],
        wave_shape: ['crumbling', 'steep'],
        wave_length: ['short', 'average'],
        wave_speed: ['average'],
        wave_direction: ['left', 'right']
      } }
      spot = assigns(:spot)
      expect(response).to redirect_to spot_path(spot)
      expect(user.spots.count).to eq(spot_count + 1)
    end
  end

  context 'GET #show' do
    it 'Should redirect unauthenticated user to login page' do
      get :show, params: { id: spot }
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should not display spot to other users and render 404 page' do
      user2 = FactoryBot.create(:user)
      sign_in user2
      get :show, params: { id: spot }
      expect(response).to have_http_status(:forbidden)
    end

    it 'Should return a 404 message if the spot is not found' do
      sign_in user
      get :show, params: { id: 1000 }
      expect(response).to have_http_status(:not_found)
    end

    it 'Should display the page if the spot is found' do
      sign_in user
      get :show, params: { id: spot }
      expect(response).to be_successful
    end
  end

  context 'GET #edit' do
    it 'Should redirect unauthenticated user to login page' do
      get :edit, params: { id: spot }
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should not let a user who did not create the spot view edit form' do
      user2 = FactoryBot.create(:user)
      sign_in user2
      get :edit, params: { id: spot }
      expect(response).to have_http_status(:forbidden)
    end

    it 'Should return a 404 message if the spot is not found' do
      sign_in user
      get :edit, params: { id: 1000 }
      expect(response).to have_http_status(:not_found)
    end

    it 'Should display the edit form if the spot is found' do
      sign_in user
      get :edit, params: { id: spot }
      expect(response).to be_successful
    end
  end

  context 'PATCH #update' do
    it 'Should redirect unauthenticated user to login page' do
      patch :update, params: { id: spot }
      expect(response).to redirect_to new_user_session_path
    end

    it 'Should not let a user who did not create the spot edit the spot' do
      user2 = FactoryBot.create(:user)
      sign_in user2
      patch :update, params: { id: spot, spot: { name: 'Monkies' } }
      expect(response).to have_http_status(:not_found)

    end

    it 'Should return a 404 message if the spot is not found' do
      sign_in user
      patch :update, params: { id: 1000 }
      expect(response).to have_http_status(:not_found)
    end

    it 'Should render validation errors' do
      sign_in user
      spot_name = spot.name
      patch :update, params: { id: spot, spot: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template :edit
      expect(spot.name).to eq(spot_name)
    end

    it 'Should successfully update spot' do
      sign_in user
      spot_name = spot.name
      patch :update, params: { id: spot, spot: { name: 'Monkies' } }
      expect(response).to be_successful
      expect(spot.name).to_not eq(spot_name)
    end
  end

  context 'DELETE #destroy' do
    it 'Should redirect unauthenticated user to login page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it 'Should not let a user who did not create the spot edit the spot'
    it 'Should return a 404 message if the spot is not found'
    it 'Should render validation errors'
    it 'Should display the edit form if the spot is found'
  end
end
