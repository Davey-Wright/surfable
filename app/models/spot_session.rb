class SpotSession < ApplicationRecord
  belongs_to :spot
  has_one :conditions,
    class_name: 'Condition::Condition',
    foreign_key: 'spot_session_id',
    inverse_of: :spot_session,
    dependent: :destroy
  accepts_nested_attributes_for :conditions

  validates_associated :conditions

  validates :conditions, presence: true
  validates :name, presence: true

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
