Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: :show

  get '/forecast' => 'static_pages#forecast'
  get '/demo' => 'static_pages#demo'

  resources :spots do
    namespace :conditions do
      resources :swells, only: %i[new create destroy]
      resources :winds, only: %i[new create destroy]
      resources :tides, except: %i[show]
    end
  end
end
