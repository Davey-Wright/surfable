require 'rails_helper'
require 'support/session_window/session_not_surfable'
require 'support/session_window/session_surfable'

RSpec.describe Sessions::Surfable do
  let(:user_conditions) { FactoryBot.create(:conditions) }
  let(:surfable) { session_surfable }
  let(:not_surfable) { session_not_surfable }

  context 'on a surfable forecast' do
    it {binding.pry}
  end

  context 'on a not surfable forecast' do

  end
end
