module Condition
  class Swell < ApplicationRecord
    belongs_to :spot

    validates :min_height, presence: true
    validates :min_period, presence: true
    validates :rating, presence: true

    before_validation :remove_nil_values_from_arrays

    private
      def remove_nil_values_from_arrays
        direction.reject!(&:blank?)
      end
  end
end
