Rails.application.routes.draw do
  root to: 'forecasts#index'
  resources :forecasts
end
