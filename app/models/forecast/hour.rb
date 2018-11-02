module Forecast
  class Hour < ApplicationRecord
    belongs_to :day
    has_one :swell
    has_one :wind

    attr_reader :value

    def initialize(data)
      @value = data.value
    end
  end
end
