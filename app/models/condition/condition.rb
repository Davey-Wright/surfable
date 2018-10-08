module Condition
  class Condition < ApplicationRecord
    belongs_to :session, inverse_of: :conditions
    has_one :swell, dependent: :delete
    has_one :tide, dependent: :delete
    has_one :wind, dependent: :delete

    accepts_nested_attributes_for :swell
    accepts_nested_attributes_for :tide
    accepts_nested_attributes_for :wind
  end
end
