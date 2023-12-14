module ForecastsHelper
  Lables = {:datetime => 'Date', :tempmax => 'Max Temp', :tempmin => 'Min Temp', :temp => 'Temp', :humidity => 'Humidity'}
  def weather_data(data)
    return nil if data.blank? or data['days'].blank?

    data.deep_symbolize_keys!

    day = data[:days].first
    html = []
    day.slice(:datetime, :tempmax, :tempmin, :temp ,:humidity).each do |key, value|
      html << content_tag(:li, "#{Lables[key]}: #{value}")
    end

    "<ul>#{html.join}</ul>".html_safe
  end
end
