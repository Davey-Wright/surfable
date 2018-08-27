Rails.application.routes.draw do
  root 'static_pages#index'
  namespace :forecasts do
    get 'windfinder/long_term', to: 'windfinder#long_term'
    get 'windfinder/short_term', to: 'windfinder#short_term'
  end
  devise_for :users
end
