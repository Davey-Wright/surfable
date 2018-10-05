class Session < ApplicationRecord
  belongs_to :spot
  has_one :conditions, class_name: 'Condition', dependent: :delete
  accepts_nested_attributes_for :conditions

  validates_presence_of :spot
  validates_presence_of :name
end
