class SurfSession < ApplicationRecord
  belongs_to :spot
  has_one :conditions,
    class_name: 'Condition::Condition',
    foreign_key: 'surf_session_id',
    inverse_of: :surf_session,
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
end
