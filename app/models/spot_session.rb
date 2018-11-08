class SpotSession < ApplicationRecord
  belongs_to :spot
  has_one :conditions,
    class_name: 'Condition::Condition',
    foreign_key: 'spot_session_id',
    inverse_of: :spot_session,
    dependent: :destroy

  accepts_nested_attributes_for :conditions

  validates_presence_of :spot
  validates_presence_of :name

  def slug
    name.downcase.gsub(' ', '-').gsub("'", '')
  end

  def to_param
    param = "#{id}-#{slug.parameterize}"
  end

  def surfable_windows(forecast)
    forecast.each { |f| Surfable::Windows.new(self, f) }
  end

  def surfable_reports(forecast)
    forecast.each { |f| Surfable::Reports.new(self, f) }
  end
end
