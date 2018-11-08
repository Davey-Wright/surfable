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

  def surf_windows(forecast)
    Surfable::Windows.new(self, forecast)
  end
end
