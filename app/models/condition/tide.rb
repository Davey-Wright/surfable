module Condition
  class Tide < ApplicationRecord
    belongs_to :spot
    before_validation :remove_nil_values_from_arrays

    validates :size, presence: true

    def self.position_rising_options
      [['Low', 0], ['1st', 1], ['2nd', 2], ['Mid', 3], ['4th', 4], ['5th', 5], ['High', 6]]
    end

    def self.position_dropping_options
      [['High', 0], ['1st', 1], ['2nd', 2], ['Mid', 3], ['4th', 4], ['5th', 5], ['Low', 6]]
    end

    def self.size_options
      [['6', 6], ['7', 7], ['8', 8], ['9', 9], ['10', 10], ['11', 11]]
    end

    private
      def remove_nil_values_from_arrays
        rising.reject!(&:blank?)
        dropping.reject!(&:blank?)
        size.reject!(&:blank?)
      end
  end
end
