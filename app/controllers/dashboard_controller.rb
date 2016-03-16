class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :dashboard, :index?
    @dashboard = DashboardFacade.new
    respond_to do |format|
      format.html
      format.csv
    end
  end
end
