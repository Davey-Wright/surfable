Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'users/:id/confirm_destroy', to: 'users#confirm_destroy', as: 'user_confirm_destroy'

  resources :users, only: [:show, :destroy] do
    get '/forecast' => 'static_pages#user_forecast'
  end

  resources :spots do
    resources :conditions
  end

end
