module Condition
  class Swell < ApplicationRecord
    belongs_to :condition

    validates :min_height, presence: true
    validates :min_period, presence: true
  end
end
