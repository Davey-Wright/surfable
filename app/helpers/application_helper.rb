module ApplicationHelper
  def body_id
    id ||= []
    id = [controller_path.split('/'), action_name].flatten.join('_')
  end

  def icon(name, opts={})
    file_path = "#{Rails.root}/app/assets/images/icons/svg/#{name}.svg"
    file = File.read(file_path).html_safe if File.exists?(file_path)
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    rotate_icon(svg, opts) if opts[:rotate].present?
    doc.to_html.html_safe
  end

  def rotate_icon(svg, opts)
    deg = opts[:rotate].to_i
    svg['style'] = "transform: rotate(#{deg}deg);"
  end

  def night_hours?(day, hour)
    return 'night-hours' if hour.value < day.first_light || hour.value > day.last_light
  end

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
