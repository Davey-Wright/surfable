require 'rails_helper'

RSpec.describe Forecast::Days, type: :model do
  before(:all) do
    @data = Forecast::Mappers.call
  end

  subject { described_class.new(@data) }

  it { expect(subject.days.count).to eq(5) }
  it { expect(subject.days.first.hours.count).to eq(8) }
  it { expect(subject.days.first.hours.first).to be_instance_of(Forecast::Hour) }
  it { expect(subject.days.first.hours.first.swell).to be_instance_of(Forecast::Swell) }
  it { expect(subject.days.first.hours.first.wind).to be_instance_of(Forecast::Wind) }
  it { expect(subject.days.first.tides).to be_instance_of(Forecast::Tide) }
end
