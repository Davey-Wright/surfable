class Spot < ApplicationRecord
  belongs_to :user
  has_many :spot_sessions, dependent: :destroy
  has_many :conditions, through: :spot_sessions

  accepts_nested_attributes_for :spot_sessions, reject_if: :session_name_blank?

  validates_presence_of :user
  validates_presence_of :name

  validates_associated :spot_sessions

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

private

  def session_name_blank?(att)
    att['name'].blank? && new_record?
  end
end
