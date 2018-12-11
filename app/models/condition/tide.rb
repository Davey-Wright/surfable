module Condition
  class Tide < ApplicationRecord
    belongs_to :condition

    validates :rising, presence: true
    validates :dropping, presence: true

    def self.position_pushing_options
      [['low', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['high', 6]]
    end

    def self.position_dropping_options
      [['high', 0], ['+1', 1], ['+2', 2], ['Mid', 3], ['-2', 4], ['-1', 5], ['low', 6]]
    end
  end
end
