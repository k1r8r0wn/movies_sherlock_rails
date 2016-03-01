class ApplicationController < ActionController::Base
  include Pundit
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_filter :set_locale
  after_action :verify_authorized, :only => :show

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error
  add_flash_types :success
end
