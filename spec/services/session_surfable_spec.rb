require 'rails_helper'

RSpec.describe 'Sessions::Surfable' do
  let(:forecast) { FactoryBot.create(:forecast) }
  let(:user_conditions) { FactoryBot.create(:session_with_conditions) }
end
