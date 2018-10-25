require 'rails_helper'

RSpec.describe SpotSession::Window do
  let(:session_conditions) { FactoryBot.create(:conditions) }
  before(:all) do
    @forecast_day = session_surfable
  end

  describe 'initializer' do
    subject { described_class.call(session_conditions, @forecast_day) }

    it 'should have times' do
      from = subject.times.first[:from]
      to = subject.times.first[:to]
      expect(from).to eq('9:47')
      expect(to).to eq('13:47')
    end

    it 'should have user session wind speed' do
      expect(subject.wind_speed).to eq(session_conditions.wind.speed)
    end

    it 'should have user session min swell height' do
      expect(subject.swell_height[:min]).to eq(session_conditions.swell.min_height)
    end

    it 'should have user session max swell height' do
      expect(subject.swell_height[:max]).to eq(session_conditions.swell.max_height)
    end

  end
end
