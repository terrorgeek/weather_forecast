class ForecastsController < ApplicationController
  before_action :validate_request
  before_action :check_cache

  def index
    res = Forecast.new.forecast(params[:input])
    @forecast = ResponseParser.parse(res)
    handle_errors
  end

  private

  def validate_request
     # Here in this case it seems overkill for only 1 input, but it's good for many more inputs
     validation_result = InputValidator.new(input: params[:input])

     if validation_result.invalid?
       # As long as request is not success, there will be a @errors
       @errors = validation_result.errors.full_messages.to_sentence
       render
     end 
  end

  def check_cache
    cache = ForecastCache.where(term: params[:input]).order(:created_at).first
    if cache.present?
      if cache.created_at < Constants::CacheTime
        cache.destroy
      else
        @forecast = { result: :success, data: { 'days' => [cache.attributes.deep_symbolize_keys] }, msg: 'From Cache!' }
        render
      end
    end
  end
  
  def handle_errors
    if @forecast[:result] == :failed
      # As long as request is not success, there will be a @errors
      @errors = "Sorry, we couldn't find the weather for this search term."
      @forecast = nil
    else
      data_to_cache = @forecast[:data].deep_symbolize_keys.fetch(:days)
      if data_to_cache.first.present?
        ForecastCache.create(data_to_cache.first.slice(:datetime, :tempmax, :tempmin, :temp ,:humidity).merge(term: params[:input]))
      end
    end
  end
end
