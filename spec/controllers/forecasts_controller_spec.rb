require 'rails_helper'
require 'byebug'

RSpec.describe ForecastsController, type: :controller do
  describe "GET index" do
    let(:api_data) {
      {'days' => [{
        :datetime => DateTime.now.strftime("%Y-%m-%d"),
        :tempmax => 12,
        :tempmin => 10,
        :temp => 11,
        :humidity => 67.3
      }]}
    }
    describe 'Without Cache' do
      it "success with valid location" do
        allow_any_instance_of(Forecast).to receive(:forecast).and_return(api_data)
        get :index, params: { input: 'New York' }
        expect(assigns(:forecast)).to eq(api_data)
      end
  
      it 'failed with empty input' do
        allow_any_instance_of(Forecast).to receive(:forecast).and_return(nil)
        get :index, params: { input: '' }
        expect(assigns(:forecast)).to eq(nil)
        expect(assigns(:errors)).to eq("Input cannot be empty!")
        expect(response.status).to eq 500
      end

      it "renders the index template but error with empty input" do
        get :index
        expect(assigns(:forecast)).to eq(nil)
        expect(assigns(:errors)).to eq("Input cannot be empty!")
        expect(response.status).to eq 500
      end

      it 'failed with invalid input which data could not be found' do
        allow_any_instance_of(Forecast).to receive(:forecast).and_return(nil)
        get :index, params: { input: 'Wonderland' }
        expect(assigns(:forecast)).to eq(nil)
        expect(assigns(:errors)).to eq("Sorry, we couldn\'t find the weather for this search term.")
        expect(response.status).to eq 500
      end

      it 'failed with invalid input that is digit' do
        allow_any_instance_of(Forecast).to receive(:forecast).and_return(nil)
        get :index, params: { input: '123123' }
        expect(assigns(:forecast)).to eq(nil)
        expect(assigns(:errors)).to eq("Input Location cannot be null and must be English letters.")
        expect(response.status).to eq 500
      end
    end

    describe 'With Cache' do
      let(:forecast_cache) { create(:forecast_cache, term: 'New York', humidity: 50, temp: 50, tempmax: 50, tempmin: 50, datetime: DateTime.now.strftime("%Y-%m-%d"), created_at: DateTime.now) }
      let(:forecast_cache_expired) { create(:forecast_cache, term: 'New York', humidity: 50, temp: 50, tempmax: 50, tempmin: 50, datetime: DateTime.now.strftime("%Y-%m-%d"), created_at: DateTime.now - 5.hours) }

      it "success with cache" do
        forecast_cache
        allow_any_instance_of(Forecast).to receive(:forecast).and_return({ result: :success, data: api_data, msg: nil})
        get :index, params: { input: 'New York' }
        expect(assigns(:forecast)).to eq({
          datetime: forecast_cache.datetime,
          tempmax: forecast_cache.tempmax,
          tempmin: forecast_cache.tempmin,
          humidity: forecast_cache.humidity,
          temp: forecast_cache.temp,
          from_cache: true
        })
      end

      it "success with expired cache" do
        forecast_cache_expired
        allow_any_instance_of(Forecast).to receive(:forecast).and_return({ result: :success, data: api_data, msg: nil})
        get :index, params: { input: 'New York' }
        expect(assigns(:forecast)).to eq({ result: :success, data: {'days' => api_data['days']}, msg: nil})
      end
    end
  end
end