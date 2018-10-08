class Session < ApplicationRecord
  belongs_to :spot
  has_one :conditions,
    class_name: 'Condition::Condition',
    foreign_key: 'session_id',
    inverse_of: :session,
    dependent: :delete

  accepts_nested_attributes_for :conditions

  validates_presence_of :spot
  validates_presence_of :name
end
