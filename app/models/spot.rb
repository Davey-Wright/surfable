class Spot < ApplicationRecord
  belongs_to :user

  has_many :swell_conditions, class_name: 'Condition::Swell', dependent: :delete_all
  
  # has_many :conditions,
  #   class_name: 'Condition::Condition',
  #   foreign_key: 'spot_id',
  #   inverse_of: :spot,
  #   dependent: :delete_all

  validates_presence_of :user
  validates_presence_of :name

  before_save :trim_attributes

  def self.wave_attribute_options
    { break_type: ['beach', 'point', 'reef'],
      direction: ['left', 'right'],
      length: ['short', 'average', 'long'],
      shape: ['crumbling', 'steep', 'hollow'],
      speed: ['slow', 'average', 'fast'] }
  end

  def trim_attributes
    wave_break_type.reject!(&:blank?)
    wave_shape.reject!(&:blank?)
    wave_direction.reject!(&:blank?)
    wave_length.reject!(&:blank?)
    wave_speed.reject!(&:blank?)
  end

  def slug
    name.downcase.gsub(' ', '-').gsub("'", '')
  end

  def to_param
    param = "#{id}-#{slug.parameterize}"
  end

end
