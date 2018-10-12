require 'rails_helper'
require 'support/spot_stub'

RSpec.describe SpotsController, type: :controller do

  let(:logged_out_user) { FactoryBot.create(:user_with_complete_spot) }

  context 'when user is logged out' do
    describe 'spots controller authentication' do
      it { expect(get :index).to redirect_to new_user_session_path }
      it { expect(get :new).to redirect_to new_user_session_path }
      it { expect(post :create, params: { spot: { name: 'Hardies' } }).to redirect_to new_user_session_path }
      it { expect(get :show, params: { id: logged_out_user.spots.first }).to redirect_to new_user_session_path }
      it { expect(get :edit, params: { id: logged_out_user.spots.first }).to redirect_to new_user_session_path }
      it { expect(patch :update, params: { id: logged_out_user.spots.first }).to redirect_to new_user_session_path }
      it { expect(delete :destroy, params: { id: logged_out_user.spots.first }).to redirect_to new_user_session_path }
    end
  end


  context 'when user is logged in' do

    before(:each) do
      @logged_in_user = FactoryBot.create(:user_with_complete_spot)
      sign_in @logged_in_user
    end

    context 'GET' do
      describe '#index' do
        it 'Should render spots/index' do
          get :index
          expect(response).to be_successful
          expect(response).to render_template :index
        end
      end

      describe '#new' do
        it 'Should render spots/new' do
          get :new
          expect(response).to be_successful
          expect(response).to render_template :new
        end
      end

      describe '#show' do
        it 'Should only return the logged in users spot' do
          get :show, params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          get :show, params: { id: 'fake_id' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should render template show if spot is found' do
          get :show, params: { id: @logged_in_user.spots.first }
          expect(response).to be_successful
          expect(response).to render_template :show
        end
      end

      describe '#edit' do
        it 'Should only return the logged in users spot' do
          get :edit, params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          get :edit, params: { id: 'fake_id' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return ' do
          get :edit, params: { id: @logged_in_user.spots.first }
          expect(response).to be_successful
          expect(response).to render_template :edit
        end
      end
    end


    context 'POST' do
      describe '#create' do
        it 'Should not create spot with invalid attributes' do
          spots = @logged_in_user.spots
          expect { post :create, params: { spot: { name: '' } } }
            .to_not change{ spots.count }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'Should permit nested params' do
          spots = @logged_in_user.spots
          expect { post :create, params: { spot: spot_stub } }
            .to change{ spots.count }.by(+1)

          session = spots.last.sessions.first
          expect(session).to_not eq(nil)
          expect(session.conditions).to be_instance_of Condition::Condition
          expect(session.conditions.swell).to be_instance_of Condition::Swell
          expect(session.conditions.tide).to be_instance_of Condition::Tide
          expect(session.conditions.wind).to be_instance_of Condition::Wind
        end

        it 'Should create a spot with valid attributes' do
          spots = @logged_in_user.spots
          expect { post :create, params: { spot: spot_stub } }
            .to change{ spots.count }.by(+1)
          expect(response).to redirect_to spot_path(spots.last)
        end
      end
    end


    context 'PATCH' do
      describe '#update' do
        it 'Should only let a spot owner update the spot' do
          patch :update, params: { id: logged_out_user.spots.first, spot: { name: 'Monkies' } }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          patch :update, params: { id: 'fake_id' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return validation errors' do
          spot = @logged_in_user.spots.first
          expect { patch :update, params: { id: spot, spot: { name: '' } }
            spot.reload }
            .to_not change { spot.name }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template :edit
        end

        it 'Should permit nested params' do
          spot = @logged_in_user.spots.first
          patch :update, params: { id: spot, spot: { name: 'Monkies' } }
          spot.reload
          session = spot.sessions.first
          expect(session).to_not eq(nil)
          expect(session.conditions).to be_instance_of Condition::Condition
          expect(session.conditions.swell).to be_instance_of Condition::Swell
          expect(session.conditions.tide).to be_instance_of Condition::Tide
          expect(session.conditions.wind).to be_instance_of Condition::Wind
        end

        it 'Should successfully update spot' do
          spot = @logged_in_user.spots.first
          expect { patch :update, params: { id: spot, spot: { name: 'Monkies' } }
            spot.reload }
            .to change { spot.name }.to('Monkies')
          expect(response).to redirect_to spot_path(spot)
        end
      end
    end


    context 'DELETE' do
      describe '#destroy' do
        it 'Should not let a user who did not create the spot delete the spot' do
          delete :destroy, params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          delete :destroy, params: { id: 'fake_id' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should successfully delete spot' do
          spots = @logged_in_user.spots
          expect { delete :destroy, params: { id: spots.first } }
            .to change { spots.count }.by(-1)
          expect(response).to redirect_to user_path(@logged_in_user)
        end

        it 'Should successfully delete all spot child associations' do
          spots = @logged_in_user.spots
          expect { delete :destroy, params: { id: spots.first } }
            .to change {spots.count }.by(-1)
          expect(Session.all.count).to eq(0)
          expect(Condition::Condition.all.count).to eq(0)
          expect(Condition::Swell.all.count).to eq(0)
          expect(Condition::Tide.all.count).to eq(0)
          expect(Condition::Wind.all.count).to eq(0)
          expect(response).to redirect_to user_path(@logged_in_user)
        end

      end
    end

  end
end