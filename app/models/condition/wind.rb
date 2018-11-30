module Condition
  class Wind < ApplicationRecord
    belongs_to :condition

    validates :title, presence: true
    validates :direction, presence: true
  end
end
