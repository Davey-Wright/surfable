require 'rails_helper'
require 'support/spot_stub'

RSpec.describe SpotsController, type: :controller do

  let(:logged_out_user) { FactoryBot.create(:user_with_complete_spot) }

  describe 'spots controller authentication' do
    context 'when user is logged out' do
      it { expect(get :index).to redirect_to new_user_session_path }
      it { expect(get :new).to redirect_to new_user_session_path }

      it { expect(post :create, params: { spot: { name: 'Hardies' } })
        .to redirect_to new_user_session_path }

      it { expect(get :show, params: { id: logged_out_user.spots.first })
        .to redirect_to new_user_session_path }

      it { expect(get :edit, params: { id: logged_out_user.spots.first })
        .to redirect_to new_user_session_path }

      it { expect(patch :update, params: { id: logged_out_user.spots.first })
        .to redirect_to new_user_session_path }

      it { expect(delete :destroy, params: { id: logged_out_user.spots.first })
        .to redirect_to new_user_session_path }
    end
  end


  context 'when user is logged in' do

    before(:each) do
      @logged_in_user = FactoryBot.create(:user_with_complete_spot)
      @logged_in_user_spots = @logged_in_user.spots
      sign_in @logged_in_user
    end

    context 'GET' do
      describe '#index' do
        it 'should be successful' do
          get :index
          expect(response).to be_successful
        end
      end

      describe '#new' do
        it 'should be successful' do
          get :new
          expect(response).to be_successful
        end
      end

      describe '#show' do
        it 'should return a 404 message if the spot is not found' do
          get :show,
            params: { id: 'fake_spot' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users spot' do
          get :show,
            params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'should be successful' do
          get :show,
            params: { id: @logged_in_user.spots.first }
          expect(response).to be_successful
        end
      end

      describe '#edit' do
        it 'should return a 404 message if the spot is not found' do
          get :edit,
            params: { id: 'fake_spot' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users spot' do
          get :edit,
            params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'should be successful' do
          get :edit,
            params: { id: @logged_in_user.spots.first }
          expect(response).to be_successful
        end
      end
    end


    context 'POST' do
      describe '#create' do
        it 'should not create spot with invalid attributes' do
          expect { post :create, params: { spot: { name: '' } } }
            .to_not change{ @logged_in_user_spots.count }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should create a spot with valid attributes' do
          spots = @logged_in_user.spots
          expect { post :create,
            params: { spot: { name: 'Morfa' } } }
            .to change{ spots.count }.by(+1)
          expect(response).to redirect_to spot_path(spots.last)
        end

        it 'should permit nested params' do
          expect { post :create,
            params: { spot: spot_stub } }
            .to change{ @logged_in_user_spots.count }.by(+1)
          session = @logged_in_user_spots.last.surf_sessions.first
          expect(session).to be_instance_of SurfSession
          expect(session.conditions).to be_instance_of Condition::Condition
          expect(session.conditions.swell).to be_instance_of Condition::Swell
          expect(session.conditions.tide).to be_instance_of Condition::Tide
          expect(session.conditions.wind).to be_instance_of Condition::Wind
        end
      end
    end


    context 'PATCH' do
      describe '#update' do
        it 'Should not update another users spot' do
          patch :update,
            params: { id: logged_out_user.spots.first, spot: { name: 'Monkies' } }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          patch :update, params: { id: 'fake_spot' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should not update with invalid session attributes' do
          spot = @logged_in_user_spots.first
          expect { patch :update,
            params: { id: spot, spot: { name: '' } }
            spot.reload }
            .to_not change { spot.name }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template :edit
        end

        it 'Should successfully update spot' do
          spot = @logged_in_user_spots.first
          expect { patch :update,
            params: { id: spot, spot: { name: 'Monkies' } }
            spot.reload }
            .to change { spot.name }.to('Monkies')
          expect(response).to redirect_to spot_path(spot)
        end
      end
    end


    context 'DELETE' do
      describe '#destroy' do
        it 'Should not delete another users spot' do
          delete :destroy,
            params: { id: logged_out_user.spots.first }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the spot is not found' do
          delete :destroy,
            params: { id: 'fake_spot' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should successfully delete spot' do
          spots = @logged_in_user_spots
          expect { delete :destroy, params: { id: spots.first } }
            .to change { spots.count }.by(-1)
          expect(response).to redirect_to user_path(@logged_in_user)
        end

        it 'Should successfully delete all spot child associations' do
          spots = @logged_in_user_spots
          expect { delete :destroy,
            params: { id: spots.first } }
            .to change {spots.count }.by(-1)
          expect(SurfSession.all.count).to eq(0)
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
