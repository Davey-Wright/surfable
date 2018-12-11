module Condition
  def self.table_name_prefix
    'condition_'
  end

  def self.direction_options
    ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw']
  end
end
