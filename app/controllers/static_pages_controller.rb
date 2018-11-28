class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :user_forecast

  def home
    redirect_to user_forecast_path(current_user) if user_signed_in?
  end

  def user_forecast
    
  end
end
