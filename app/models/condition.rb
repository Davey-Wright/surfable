module Condition
  def self.table_name_prefix
    'condition_'
  end

  def self.direction_options
    ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw']
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

    validates :name, presence: true
    validates :swell, presence: true
    validates :tide, presence: true
    validates :winds, presence: true
  end

  RATINGS = {
		'one star': '1_star',
    'two stars': '2_stars',
    'three stars': '3_stars',
    'four stars': '4_stars',
    'five stars': '5_stars'
	}

	def humanized_rating
		RATINGS.invert[self.rating]
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
