require 'rails_helper'

RSpec.describe Forecast::MagicSeaweed::ForecastRequest do

  let(:key) { ENV['MSW_KEY'] }
  let(:spot) { 'porthcawl' }

  subject { described_class }

  context 'with invalid api key' do
    let(:request) { subject.new(nil, spot).response }
    it { expect(request.success?).to eq(false) }
    it { expect(request.error[:code]).to_not be(200) }
  end

  context 'with invalid spot' do
    let(:request) { subject.new(key, nil).response }
    it { expect(request.success?).to eq(false) }
    it { expect(request.error[:code]).to_not eq(200) }
  end

  context 'with valid key and spot' do
    let(:request) { subject.new(key, spot).response }
    it { expect(request.success?).to eq(true) }
    it { expect(request.http_response.count).to eq(40) }
    it { expect(request.forecast.days.count).to eq(5) }
  end

end
