class UserSessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are logged in.'
      redirect_to user_path(:id)
    else
      flash[:error] = 'There was a problem logging in. Please check your email and password.'
      render :new
    end

  end
end
