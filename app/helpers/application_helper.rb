module ApplicationHelper
  def tide_offsets_value(type, value)
    case value
    when 1
      '1st'
    when 2
      '2nd'
    when 3
      '3rd'
    when 4
      '4th'
    when 5
      '5th'
    when 6
      '6th'
    end
  end

  def display_tide_offset_values(type)
    if @spot.tide[type].empty?
      'Not Defined'
    else
      str = ''
      @spot.tide[type].each { |value| str += "#{tide_offsets_value(type, value)} " }
      str
    end
  end

  def display_attribute(att)
    if att.is_a? Array
      if att.empty?
        'Not Defined'
      else
        str = ''
        att.each { |prop| str += "#{prop} " }
        str
      end
    else
      att.nil? ? 'Not Defined' : att
    end
  end
end
