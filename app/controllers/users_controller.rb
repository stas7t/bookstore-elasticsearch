class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update_email
    @user = current_user
    @user.skip_password_validation = true
    @user.skip_confirmation!
    @user.skip_reconfirmation!
    if @user.update_without_password(user_params)
      bypass_sign_in(@user)
      flash[:success] = 'Email successfuly changed'
      redirect_to settings_privacy_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      flash[:success] = 'Password successfuly changed'
      redirect_to settings_privacy_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end
end
