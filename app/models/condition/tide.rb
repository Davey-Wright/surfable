module Condition
  class Tide < ApplicationRecord
    belongs_to :spot
    before_validation :remove_nil_values_from_arrays

    validates :size, presence: true

    def self.position_offset_options
      [['1st', 1], ['2nd', 2], ['3rd', 3], ['4th', 4], ['5th', 5], ['6th', 6]]
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
