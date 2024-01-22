module ForecastsHelper
  Lables = {:datetime => 'Date', :tempmax => 'Max Temp', :tempmin => 'Min Temp', :temp => 'Temp', :humidity => 'Humidity'}
  def weather_data(data)
    return nil if data.blank?
    html = []
    data.slice(:datetime, :tempmax, :tempmin, :temp ,:humidity).each do |key, value|
      html << content_tag(:li, "#{Lables[key]}: #{value}")
    end

    "<ul>#{html.join}</ul>".html_safe
  end

  def from_cache(data)
    return '<p>From Cache: No</p>'.html_safe if data[:from_cache].blank?
    return '<p>From Cache: Yes</p>'.html_safe
  end
end
