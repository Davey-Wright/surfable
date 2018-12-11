module Condition
  class Swell < ApplicationRecord
    belongs_to :spot

    validates :min_height, presence: true
    validates :min_period, presence: true
    validates :rating, presence: true
  end
end
