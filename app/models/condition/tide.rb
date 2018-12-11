module Condition
  class Tide < ApplicationRecord
    belongs_to :condition
    before_validation :set_defaults

    def self.size_options
      ['small', 'average', 'large', 'massive']
    end

    def self.position_pushing_options
      [['low', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['high', 6]]
    end

    def self.position_dropping_options
      [['high', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['low', 6]]
    end

    private

      def set_defaults
        self.position_low_high ||= [0, 0]
        self.position_high_low ||= [0, 0]
      end
  end
end
