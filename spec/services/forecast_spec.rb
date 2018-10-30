require 'rails_helper'

RSpec.describe Forecast::API do
  before(:all) do
    @forecast = described_class.new
  end

  it { expect(@forecast.days.count).to eq(4) }
  it { expect(@forecast.days.first.hours.count).to eq(8)}
  it { expect(@forecast.days.first.hours.first.swell).to be_instance_of(Forecast::Swell) }
  it { expect(@forecast.days.first.hours.first.wind).to be_instance_of(Forecast::Wind) }
  it { expect(@forecast.days.first.tides).to be_instance_of(Forecast::Tide) }
end
