module Condition
  class Wind < ApplicationRecord
    belongs_to :condition

    def self.speed_options
      ['< 5', '< 10', '< 15', '< 20', '< 30']
    end

    def self.name_options
      ['onshore', 'crossshore', 'offshore']
    end
  end
end
