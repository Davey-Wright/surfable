module Surfable
  class Forecast
    attr_accessor :rating, :tide, :values
    def initialize(rating, tide, values)
      @rating = rating
      @tide = tide
      @values = values
    end
  end
end
