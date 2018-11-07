require 'support/spot_session_stub'
require 'support/good_forecast_stub'

RSpec.describe Surfable::Window do
  let(:spot_session) { spot_session_stub }
  let(:good_forecast) { good_forecast_stub }

  context 'With a good forecast' do
    subject { described_class.new(spot_session, good_forecast) }

    describe 'Attributes' do
    end

    describe 'Methods' do
      context 'With a good forecast' do
        describe 'match_tides' do
          it 'should add user offsets' do
            subject.tides
            expect(subject.times.first[:from]).to eq('7:07')
            expect(subject.times.first[:to]).to eq('15:07')
          end
        end

        describe 'match_swell' do
        end

        describe 'match_wind' do
        end

        describe  'match_daylight_hours' do
        end
      end
    end
  end

  context 'With a bad forecast' do
    describe 'Attributes' do
    end

    describe 'Methods' do
      describe 'match_tides' do
      end

      describe 'match_swell' do
      end

      describe 'match_wind' do
      end

      describe  'match_daylight_hours' do
      end
    end
  end

end
