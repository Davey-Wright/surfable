module Condition
  class Wind < ApplicationRecord
    belongs_to :spot

    before_validation :remove_nil_values_from_arrays

    validates :direction, presence: true
    validates :speed, presence: true
    validates :rating, presence: true

    def self.name_options
      ['onshore', 'crossshore', 'offshore']
    end

    private

      def remove_nil_values_from_arrays
        direction.reject!(&:blank?)
        name.reject!(&:blank?)
      end
  end
end
