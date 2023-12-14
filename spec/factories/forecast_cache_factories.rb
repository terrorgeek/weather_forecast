FactoryBot.define do
  factory :forecast_cache do
    term { "New York" }
    temp { 56.6 }
    tempmax { 56.6 }
    tempmin { 56.6 }
    humidity { 78.6 }
    datetime { DateTime.now }
  end
end