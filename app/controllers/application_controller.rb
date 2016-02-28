class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  protect_from_forgery with: :exception

  def logged_in?
    current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if current_user
      true
    else
      redirect_to new_user_session_path, notice: 'You must be logged in to access that page.'
    end
  end
end
