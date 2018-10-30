require 'rails_helper'
require 'support/surf_session_stub'

RSpec.describe SurfSessionsController, type: :controller do

  let(:logged_out_user) { FactoryBot.create(:user_with_complete_spot) }
  let(:logged_out_user_spot) { logged_out_user.spots.first }
  let(:logged_out_user_surf_session) { logged_out_user_spot.surf_sessions.first }

  describe 'sessions authentication' do
    context 'when user is logged out' do
      it { expect(get :new, params: { spot_id: logged_out_user_spot })
        .to redirect_to new_user_session_path }

      it { expect(post :create,
        params: { spot_id: logged_out_user_spot, surf_session: surf_session_stub })
        .to redirect_to new_user_session_path }

      it { expect(get :show,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session })
        .to redirect_to new_user_session_path }

      it { expect(get :edit,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session })
        .to redirect_to new_user_session_path }

      it { expect(patch :update,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session })
        .to redirect_to new_user_session_path }

      it { expect(delete :destroy,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session })
        .to redirect_to new_user_session_path }
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @logged_in_user = FactoryBot.create(:user_with_complete_spot)
      @logged_in_user_spot = @logged_in_user.spots.first
      @logged_in_user_session = @logged_in_user_spot.surf_sessions.first
      sign_in @logged_in_user
    end

    context 'GET' do
      describe '#new' do
        it 'should return a 404 message if the spot is not found' do
          get :new,
            params: { spot_id: 'fake_spot' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users spot' do
          get :new,
            params: { spot_id: logged_out_user_spot }
          expect(response).to have_http_status(:not_found)
        end

        it 'should be successful' do
          get :new,
            params: { spot_id: @logged_in_user_spot }
          expect(response).to be_successful
        end
      end

      describe '#show' do
        it 'should return a 404 message if the session is not found' do
          get :show,
            params: { spot_id: @logged_in_user_spot, id: 'fake_session' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users session' do
          get :show,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session }
          expect(response).to have_http_status(:not_found)
        end

        it 'should be successful' do
          get :show,
            params: { spot_id: @logged_in_user_spot, id: @logged_in_user_session }
          expect(response).to be_successful
        end
      end

      describe '#edit' do
        it 'should return a 404 message if the session is not found' do
          get :edit,
            params: { spot_id: @logged_in_user_spot, id: 'fake_session' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users session' do
          get :edit,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session }
          expect(response).to have_http_status(:not_found)
        end

        it 'should render sessions/edit' do
          get :edit,
            params: { spot_id: @logged_in_user_spot, id: @logged_in_user_session }
          expect(response).to be_successful
        end
      end
    end


    context 'POST' do
      describe '#create' do
        it 'should not create session with invalid attributes' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot, surf_session: { name: '' } } }
            .to_not change{ @logged_in_user_spot.surf_sessions.count }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not create session for another users spot' do
          expect { post :create,
            params: { spot_id: logged_out_user_spot,
              surf_session: { name: 'Logging', board_type: ['longboard'] } } }
            .to_not change{ @logged_in_user_spot.surf_sessions.count }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should create a session with valid attributes' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot,
              surf_session: { name: 'Logging', board_type: ['longboard'] } } }
            .to change{ @logged_in_user_spot.surf_sessions.count }.by(+1)
          spot = @logged_in_user_spot
          session = @logged_in_user_spot.surf_sessions.last
          expect(response).to redirect_to spot_surf_session_path(spot, session)
        end

        it 'should permit nested params for conditions' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot, surf_session: surf_session_stub } }
            .to change{ @logged_in_user_spot.surf_sessions.count }.by(+1)
          conditions = @logged_in_user_session.conditions
          expect(conditions).to be_instance_of Condition::Condition
          expect(conditions.swell).to be_instance_of Condition::Swell
          expect(conditions.tide).to be_instance_of Condition::Tide
          expect(conditions.wind).to be_instance_of Condition::Wind
        end
      end
    end


    context 'PATCH' do
      describe '#update' do
        it 'Should not update another users session' do
          patch :update,
            params: {
              spot_id: logged_out_user_spot,
              id: logged_out_user_surf_session,
              surf_session: { name: 'Logging' } }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the session is not found' do
          patch :update,
            params: {
              spot_id: @logged_in_user_spot,
              id: 'fake_session',
              surf_session: { name: 'Logging'} }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should not update with invalid session attributes' do
          expect { patch :update,
            params: {
              spot_id: @logged_in_user_spot,
              id: @logged_in_user_session,
              surf_session: { name: '' } }
            @logged_in_user_session.reload }
            .to_not change { @logged_in_user_session.name }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template :edit
        end

        it 'Should successfully update spot' do
          spot = @logged_in_user_spot
          session = @logged_in_user_session
          expect { patch :update,
            params: {
              spot_id: spot,
              id: session,
              surf_session: { name: 'Logging' } }
            session.reload }
            .to change { session.name }.to('Logging')
          expect(response).to redirect_to spot_surf_session_path(spot, session)
        end

        it 'Should update nested params' do
          spot = @logged_in_user_spot
          session = @logged_in_user_session
          expect { patch :update,
            params: {
              spot_id: spot,
              id: session,
              surf_session: {
                conditions_attributes: {
                  swell_attributes: {
                    min_height: 100
                  }
                }
            } }
            session.reload }
            .to change { session.conditions.swell.min_height }.to(100)
            expect(response).to redirect_to spot_surf_session_path(spot, session)
        end
      end
    end


    context 'DELETE' do
      describe '#destroy' do
        it 'Should not delete another users spot' do
          delete :destroy,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_surf_session }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the session is not found' do
          delete :destroy,
            params: { spot_id: @logged_in_user_spot, id: 'fake_session' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should successfully delete spot' do
          spot = @logged_in_user_spot
          session = @logged_in_user_session
          expect { delete :destroy,
            params: { spot_id: spot, id: session } }
            .to change { spot.surf_sessions.count }.by(-1)
          expect(response).to redirect_to spot_path(spot)
        end

        it 'Should successfully delete all child associations' do
          spot = @logged_in_user_spot
          session = @logged_in_user_session
          expect { delete :destroy,
            params: { spot_id: spot, id: session } }
            .to change {spot.surf_sessions.count }.by(-1)
          expect(Condition::Condition.all.count).to eq(0)
          expect(Condition::Swell.all.count).to eq(0)
          expect(Condition::Tide.all.count).to eq(0)
          expect(Condition::Wind.all.count).to eq(0)
          expect(response).to redirect_to spot_path(spot)
        end
      end
    end


  end
end
