module Condition
  def self.table_name_prefix
    'condition_'
  end

  def self.direction_options
    ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
  end
end
