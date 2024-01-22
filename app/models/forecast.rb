class Forecast
  attr_reader :provider
  
  def initialize(provider: VisualCrossing.new)
    @provider = provider
  end

  def forecast(input)
    puts "API hit!!!"
    @provider.forecast(input)
  end
end