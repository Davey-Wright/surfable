module Condition
  def self.table_name_prefix
    'condition_'
  end

  class Condition < ApplicationRecord
    belongs_to :surf_session, inverse_of: :conditions
    has_one :swell, dependent: :destroy, class_name: 'Condition::Swell'
    has_one :tide, dependent: :destroy, class_name: 'Condition::Tide'
    has_one :wind, dependent: :destroy, class_name: 'Condition::Wind'

    accepts_nested_attributes_for :swell
    accepts_nested_attributes_for :tide
    accepts_nested_attributes_for :wind
  end
end
