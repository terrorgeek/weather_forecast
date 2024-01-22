class ForecastsController < ApplicationController
  before_action :validate_request

  rescue_from JSON::ParserError, with: :api_call_error
  rescue_from RestClient::BadRequest, with: :api_call_error
  rescue_from StandardError, with: :api_call_error
  rescue_from ForecastException::InputInvalidError, with: :input_invalid
  rescue_from ForecastException::InputEmptyError, with: :input_empty

  def index
    @forecast = check_cache
    return if @forecast.present?

    res = Forecast.new.forecast(params[:input])
    @forecast = ResponseParser.parse(res)

    store_cache
  end

  private

  def validate_request
    raise ForecastException::InputEmptyError if params[:input].blank? 
    validation_result = InputValidator.new(input: params[:input])
    raise ForecastException::InputInvalidError.new(validation_result.errors.full_messages.to_sentence) if validation_result.invalid?
  end

  def check_cache
    cache = ForecastCache.where(term: params[:input]).order(:created_at).first
    if cache.blank? or cache.created_at < Constants::CacheTime
      cache.destroy if cache.present?
      return nil
    else
      return {
        datetime: cache.datetime,
        tempmax: cache.tempmax,
        tempmin: cache.tempmin,
        humidity: cache.humidity,
        temp: cache.temp,
        from_cache: true
      }
    end
  end
  
  def input_invalid(e)
    @errors = e.message
    render :index, status: 500
  end

  def input_empty
    @errors = 'Input cannot be empty!'
    render :index, status: 500
  end

  def api_call_error
    @errors = 'Sorry, we couldn\'t find the weather for this search term.'
    render :index, status: 500
  end

  def store_cache
    ForecastCache.create(@forecast.slice(:datetime, :tempmax, :tempmin, :temp, :humidity).merge(term: params[:input]))
  end
end
