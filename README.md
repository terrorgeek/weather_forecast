## Project Setup:

1, bundle install
2, rake db:create
3, rake db:migrate

## Run Rspec:
rspec

## Start project:
rails s

Then visit:
http://localhost:3000 OR
http://localhost:3000/forecasts

Then in 'Your location:' text input, you can input location by City or Address


## Quick Descriptions of the code:
1. InputValidator is to incercept the request cycle and return if input is invalid
2. Class Forecast is a generic class and it's to be extended by other Weather API providers, VisualCrossing is
just one of them. Any new incoming Weather API can be put into a new class and it's complying SOLID rules.
3. ResponseParser is to make sure the response if consistent which always includes keys 'result', 'data' and 'msg' and capture exceptions, but never manupulate the 'data'.
4. View Helper function 'weather_data' is only responsible for manipulating data in view.
5. In the only controller 'ForecastsController', 3 main functions: validate_request, check_cache and handle_errors
   validate_request is using InputValidator in #1 to validate the input by using ActiveModel.
   check_cache is also to incercept the request by checking Cache, and return consistent response if hit.
   handle_errors happens if cache is not hit and handle errors if the actual request failed when really hit the API.