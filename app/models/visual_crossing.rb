class VisualCrossing
  def initialize
    @api_key = Rails.application.credentials.config[:visual_crossing_api_key]
    @base_url = Rails.application.credentials.config[:forecast_api_base_url]
  end

  def forecast(input)
    encoded_input = URI.encode(input)
    res = RestClient.get "#{@base_url}/#{encoded_input}", {params: {key: @api_key}}
    res.body
  end
end