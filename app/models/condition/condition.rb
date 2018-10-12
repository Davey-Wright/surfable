module Condition
  class Condition < ApplicationRecord
    belongs_to :session, inverse_of: :conditions
    has_one :swell, dependent: :destroy
    has_one :tide, dependent: :destroy
    has_one :wind, dependent: :destroy

    accepts_nested_attributes_for :swell
    accepts_nested_attributes_for :tide
    accepts_nested_attributes_for :wind

  end
end
