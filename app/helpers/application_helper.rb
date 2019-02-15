module ApplicationHelper
  def tide_offsets_value(type, value)
    case value
    when 0
      type == 'rising' ? 'Low' : 'High'
    when 6
      type == 'rising' ? 'High' : 'Low'
    when 1
      '1st'
    when 2
      '2nd'
    when 3
      'Mid'
    when 4
      '4th'
    when 5
      '5th'
    end
  end

  def display_tide_offset_values(type)
    str = ''
    if @spot.tide[type].empty?
      str = 'Not Defined'
    else
      @spot.tide[type].each { |value| str += "#{tide_offsets_value(type, value)} " }
    end
    return str
  end
end
