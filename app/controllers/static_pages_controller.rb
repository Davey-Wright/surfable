class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :forecast
  respond_to :html, :js

  def home
    redirect_to forecast_path(current_user) if user_signed_in?
  end

  def forecast
    @forecast = Forecast::Days.new(Forecast::Mappers.call)
    spots = current_user.spots.all
    if !@forecast.nil? && !spots.nil?
      @surfable = Surfable::Forecaster.call(spots, @forecast)
    end
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
