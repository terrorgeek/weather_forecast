class Forecast
  attr_reader :provider
  
  def initialize(provider: VisualCrossing.new)
    @provider = provider
  end

  def forecast(input)
    begin
      puts "API hit!!!"
      @provider.forecast(input)
    rescue RestClient::BadRequest => e
      nil
    end
  end
end