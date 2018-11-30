module Condition
  def self.table_name_prefix
    'condition_'
  end

  class Condition < ApplicationRecord
    belongs_to :spot, inverse_of: :conditions

    has_one :swell, dependent: :destroy, class_name: 'Condition::Swell'
    has_one :tide, dependent: :destroy, class_name: 'Condition::Tide'
    has_many :winds, dependent: :delete_all, class_name: 'Condition::Wind'

    accepts_nested_attributes_for :swell
    accepts_nested_attributes_for :tide
    accepts_nested_attributes_for :winds

    validates_associated :swell, :tide, :winds

    validates :swell, presence: true
    validates :tide, presence: true
    validates :winds, presence: true
  end

  def slug
    name.downcase.gsub(' ', '-').gsub("'", '')
  end

  def to_param
    param = "#{id}-#{slug.parameterize}"
  end

  def surfable(forecast)
    Surfable::Windows.new(self, forecast)
  end
end
