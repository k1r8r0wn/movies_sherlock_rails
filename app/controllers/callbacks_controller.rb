class CallbacksController < Devise::OmniauthCallbacksController
  def all
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
  end

  alias_method :all, :twitter
  alias_method :all, :google_oauth2
  alias_method :all, :github
end
