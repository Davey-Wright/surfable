module Forecast

  class Days
    extend ActiveModel

    attr_reader :days

    def initialize(data)
      @days = data.map{ |day| Day.new day }
    end
  end

end
