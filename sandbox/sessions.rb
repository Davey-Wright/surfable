belongs_to :spots
has_many :conditions

session = {
  name: string
  board_type: ['shortboard', 'longboard', 'funboard', 'fish', 'foamy', 'mini-mal', 'SUP']
  average_condtion: condition
  good_condition: condition
}
