require 'rails_helper'
require 'support/spot_session/session_surfable'

RSpec.describe SpotSession::Surfable do
  before(:all) do
    @forecast_day = session_surfable
  end

  let(:surf_session_conditions) { FactoryBot.create(:conditions) }
  let(:surf_session_window) { SpotSession::Window.call(session_conditions, @forecast_day) }

  context 'on a surfable forecast' do
    subject { described_class.new(session_window) }
    it { binding.pry }
  end

end
