class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      flash[:success] = 'Password reset instructions sent! Please check your email.'
      redirect_to sign_in_path
    else
      flash.now[:error] = 'Email not found.'
      render :new
    end
  end
end
