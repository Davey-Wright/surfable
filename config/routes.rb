Rails.application.routes.draw do
  root 'static_pages#index'
  get '/api/forecasts/long_term', to: 'api/forecasts#long_term'
  get '/api/forecasts/short_term', to: 'api/forecasts#short_term'
  get '/forecast', to: 'forecasts#index'
  devise_for :users
end
