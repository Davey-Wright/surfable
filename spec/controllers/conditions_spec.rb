require 'rails_helper'
require 'support/spot_condition_stub'

RSpec.describe ConditionsController, type: :controller do

  let(:logged_out_user) { FactoryBot.create(:user_with_spot_conditions) }
  let(:logged_out_user_spot) { logged_out_user.spots.first }
  let(:logged_out_user_condition) { logged_out_user_spot.conditions.first }

  describe 'conditions authentication' do
    context 'when user is logged out' do
      it { expect(get :new, params: { spot_id: logged_out_user_spot })
        .to redirect_to new_user_session_path }

      # it do
      #   let(:create_session) do
      #     post :create, params: {
      #       spot_id: logged_out_user_spot,
      #       condition: condition_stub
      #     }
      #   end
      #
      #   expect(create_session).to redirect_to new_user_session_path
      # end

      it { expect(get :show,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_condition })
        .to redirect_to new_user_session_path }

      it { expect(get :edit,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_condition })
        .to redirect_to new_user_session_path }

      it { expect(patch :update,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_condition })
        .to redirect_to new_user_session_path }

      it { expect(delete :destroy,
        params: { spot_id: logged_out_user_spot, id: logged_out_user_condition })
        .to redirect_to new_user_session_path }
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @logged_in_user = FactoryBot.create(:user_with_spot_conditions)
      @logged_in_user_spot = @logged_in_user.spots.first
      @logged_in_user_condition = @logged_in_user_spot.conditions.first
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
        it 'should return a 404 message if the condition is not found' do
          get :show,
            params: { spot_id: @logged_in_user_spot, id: 'fake_condition' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users condition' do
          get :show,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_condition }
          expect(response).to have_http_status(:not_found)
        end

        it 'should be successful' do
          get :show,
            params: { spot_id: @logged_in_user_spot, id: @logged_in_user_condition }
          expect(response).to be_successful
        end
      end

      describe '#edit' do
        it 'should return a 404 message if the condition is not found' do
          get :edit,
            params: { spot_id: @logged_in_user_spot, id: 'fake_condition' }
          expect(response).to have_http_status(:not_found)
        end

        it 'should not return another users condition' do
          get :edit,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_condition }
          expect(response).to have_http_status(:not_found)
        end

        it 'should render conditions/edit' do
          get :edit,
            params: { spot_id: @logged_in_user_spot, id: @logged_in_user_condition }
          expect(response).to be_successful
        end
      end
    end


    context 'POST' do
      describe '#create' do
        it 'should not create condition with invalid attributes' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot,
              condition: { name: 'Logging', board_type: ['longboard'] } } }
            .to_not change{ @logged_in_user_spot.conditions.count }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not create condition for another users spot' do
          expect { post :create,
            params: { spot_id: logged_out_user_spot,
              condition: { name: 'Logging', board_type: ['longboard'] } } }
            .to_not change{ @logged_in_user_spot.conditions.count }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should create a condition with valid attributes' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot, condition: spot_condition_stub } }
            .to change{ @logged_in_user_spot.conditions.count }.by(+1)
          spot = @logged_in_user_spot
          condition = @logged_in_user_spot.conditions.last
          expect(response).to redirect_to spot_condition_path(spot, condition)
        end

        it 'should permit nested params for conditions' do
          expect { post :create,
            params: { spot_id: @logged_in_user_spot, condition: spot_condition_stub } }
            .to change{ @logged_in_user_spot.conditions.count }.by(+1)
          conditions = @logged_in_user_condition
          expect(conditions).to be_instance_of Condition::Condition
          expect(conditions.swell).to be_instance_of Condition::Swell
          expect(conditions.tide).to be_instance_of Condition::Tide
          expect(conditions.wind).to be_instance_of Condition::Wind
        end
      end
    end


    context 'PATCH' do
      describe '#update' do
        it 'Should not update another users condition' do
          patch :update,
            params: {
              spot_id: logged_out_user_spot,
              id: logged_out_user_condition,
              condition: { name: 'Logging' } }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the condition is not found' do
          patch :update,
            params: {
              spot_id: @logged_in_user_spot,
              id: 'fake_condition',
              condition: { name: 'Logging'} }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should not update with invalid condition attributes' do
          spot = @logged_in_user_spot
          condition = @logged_in_user_condition
          expect { patch :update,
            params: {
              spot_id: spot,
              id: condition,
              condition: {
                swell_attributes: {
                  min_height: 100
                }
            } }
            @logged_in_user_condition.reload }
            .to_not change { @logged_in_user_condition.swell.min_height}
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template :edit
        end

        it 'Should successfully update spot' do
          spot = @logged_in_user_spot
          condition = @logged_in_user_condition
          expect { patch :update,
            params: {
              spot_id: spot,
              id: condition,
              condition: {
                name: 'Logging'
            } }
            condition.reload }
            .to change { condition.name }.to('Logging')
          expect(response).to redirect_to spot_condition_path(spot, condition)
        end

        it 'Should update nested params' do
          spot = @logged_in_user_spot
          condition = @logged_in_user_condition
          expect { patch :update,
            params: {
              spot_id: spot,
              id: condition,
              condition: {
                name: 'melaka',
                swell_attributes: {
                  min_height: 100,
                  max_height: nil,
                  min_period: 10,
                  direction: ['w', 'sw', 's']
                }
            } }
            condition.reload }
            .to change { condition.swell.min_height }.to(100)
            expect(response).to redirect_to spot_condition_path(spot, condition)
        end
      end
    end


    context 'DELETE' do
      describe '#destroy' do
        it 'Should not delete another users spot' do
          delete :destroy,
            params: { spot_id: logged_out_user_spot, id: logged_out_user_condition }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should return a 404 message if the condition is not found' do
          delete :destroy,
            params: { spot_id: @logged_in_user_spot, id: 'fake_condition' }
          expect(response).to have_http_status(:not_found)
        end

        it 'Should successfully delete condition' do
          spot = @logged_in_user_spot
          condition = @logged_in_user_condition
          expect { delete :destroy,
            params: { spot_id: spot, id: condition } }
            .to change { spot.conditions.count }.by(-1)
          expect(response).to redirect_to spot_path(spot)
        end

        it 'Should successfully delete all child associations' do
          spot = @logged_in_user_spot
          condition = @logged_in_user_condition
          expect { delete :destroy,
            params: { spot_id: spot, id: condition } }
            .to change {spot.conditions.count }.by(-1)
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
