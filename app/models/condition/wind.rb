module Condition
  class Wind < ApplicationRecord
    belongs_to :spot

    validates :direction, presence: true
    validates :speed, presence: true
    validates :rating, presence: true

    def self.name_options
      ['onshore', 'crossshore', 'offshore']
    end
  end
end
