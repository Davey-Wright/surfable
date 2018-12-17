class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = get_user
  end

  def confirm_destroy
    @user = get_user
    @user_confirmation = ConfirmationCode.new
    session[:confirmation_code] = SecureRandom.base64(4).slice(0...6) if @user.provider
  end

  def destroy
    @user = get_user
    if @user.provider
      if session[:confirmation_code] == delete_confirmation_params[:value]
        if @user.destroy
          flash[:notice] = 'Your account has been deleted successfully'
          redirect_to root_path
        end
      else
        flash[:alert] = "Sorry your confirmation code did not match please try again"
        redirect_to user_confirm_destroy_path
      end
    else
      if @user.destroy_with_password(user_params[:current_password])
        flash[:notice] = 'Your account has been deleted successfully'
        redirect_to root_path
      else
        flash[:alert] = "Your password is invalid"
        redirect_to user_confirm_destroy_path
      end
    end
  end

  private

  def get_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :current_password)
  end

  def delete_confirmation_params
    params.require(:confirmation_code).permit(:value)
  end

end
