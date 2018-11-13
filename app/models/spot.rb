class Spot < ApplicationRecord
  belongs_to :user

  has_many :conditions,
    class_name: 'Condition::Condition',
    foreign_key: 'spot_id',
    inverse_of: :spot,
    dependent: :destroy
    
  accepts_nested_attributes_for :conditions

  validates_presence_of :user
  validates_presence_of :name
  validates_associated :conditions

  def self.wave_attribute_options
    { break_type: ['beach', 'point', 'reef'],
      direction: ['left', 'right'],
      length: ['short', 'average', 'long'],
      shape: ['crumbling', 'steep', 'hollow'],
      speed: ['slow', 'average', 'fast'] }
  end

  def slug
    name.downcase.gsub(' ', '-').gsub("'", '')
  end

  def to_param
    param = "#{id}-#{slug.parameterize}"
  end

end
