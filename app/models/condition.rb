class Condition < ApplicationRecord
  belongs_to :session

  validates_presence_of :session
end
