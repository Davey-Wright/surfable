class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = set_user || not_found
  end

  private

  def set_user
    current_user if current_user.id == params[:id].to_i
  end

  def not_found
    render file: "#{Rails.root}/public/404.html.slim", layout: false, status: :not_found
  end
end
