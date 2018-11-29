class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :user_forecast

  def home
    redirect_to user_forecast_path(current_user) if user_signed_in?
  end

  def user_forecast
  end

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
