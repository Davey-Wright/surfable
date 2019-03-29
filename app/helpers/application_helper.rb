module ApplicationHelper
  def body_id
    id ||= []
    id = [controller_path.split('/'), action_name].flatten.join('_')
  end

  # def primary_navigation_links
  #   if body_id == 'static_pages_home'
  #     [
  #       { text: 'Demo', href: demo_path },
  #       { text: 'Sign Up', href: new_user_registration_path },
  #       { text: 'Log In', href: new_user_session_path}
  #     ]
  #   elsif body_id == 'static_pages_forecast'
  #     [
  #       { text: 'Home', href: root_path },
  #       { text: 'Forecast', href: forecast_path },
  #       { text: 'Spots', href: spots_path },
  #       { text: 'Sign Up', href: new_user_registration_path }
  #     ]
  #   end
  #   links = {
  #     demo: [
  #       { text: 'Home', href: root_path },
  #       { text: 'Forecast', href: forecast_path },
  #       { text: 'Spots', href: spots_path },
  #       { text: 'Sign Up', href: new_user_registration_path }
  #     ],
  #     user: [
  #       { text: 'Forecast', href: forecast_path },
  #       { text: 'Spots', href: spots_path },
  #       { text: 'Dashboard', href: user_path(current_user) },
  #       { text: 'Sign Out',
  #         href: destroy_user_session_path,
  #         method: :delete,
  #         id: 'sign_out'
  #       }
  #     ]
  #   }
  # end

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
