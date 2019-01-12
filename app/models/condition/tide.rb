module Condition
  class Tide < ApplicationRecord
    belongs_to :spot

    before_validation :remove_nil_values_from_arrays

    def self.position_rising_options
      [['low', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['high', 6]]
    end

    def self.position_dropping_options
      [['high', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['low', 6]]
    end

    private
      def remove_nil_values_from_arrays
        rising.reject!(&:blank?)
        dropping.reject!(&:blank?)
        size.reject!(&:blank?)
      end
  end
end
