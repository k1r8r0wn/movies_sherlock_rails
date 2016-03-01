module ApplicationHelper
  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def authorize_user
    user = User.find(params[:id])
    authorize user
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
