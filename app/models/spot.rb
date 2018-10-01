class Spot < ApplicationRecord
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :name

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
