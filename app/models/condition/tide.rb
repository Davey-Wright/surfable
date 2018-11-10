module Condition
  class Tide < ApplicationRecord
    belongs_to :condition
    before_validation :set_defaults

    validates :size, presence: true

    private

      def set_defaults
        self.position_low_high ||= [0, 0]
        self.position_high_low ||= [0, 0]
      end
  end
end
