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
To not try to make the project too fancy, I put the request level validation in controller ot make it explicitly readbale
and model level validation in model.

I'm highly using `rescue_from` to capture errors for the invalid input in the controller level.

In model folder, `Forecast` is a class that can be injected with any 3rd party weather forecast API vendor.

All tests are in spec folder with using RSpec.