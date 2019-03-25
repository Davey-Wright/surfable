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
        not_defined
      else
        list = "<ul>"
        att.each { |a| list += "<li>#{a}</li>" }
        list += "</ul>"
        return list.html_safe
      end
    else
      not_defined
    end
  end

  def not_defined
    return "<p>Not Defined</p>".html_safe
  end
end
