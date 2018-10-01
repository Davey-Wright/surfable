Rails.application.routes.draw do
  root 'static_pages#index'
  namespace :forecasts do
    get 'windfinder/long_term', to: 'windfinder#long_term'
    get 'windfinder/short_term', to: 'windfinder#short_term'
  end
  devise_for :users, :controllers => {
    registrations: 'registrations',
    sessions: 'sessions',
    omniauth_callbacks: 'omniauth_callbacks'}
  resources :users, only: [:show, :destroy]
  resources :spots
  get 'users/:id/confirm_destroy', to: 'users#confirm_destroy', as: 'user_confirm_destroy'
end
