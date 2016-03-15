class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :dashboard, :index?
    @dashboard = DashboardFacade.new
    respond_to do |format|
      format.html
      format.csv do
        csv_data = CSV.generate do |csv|
          # header
          csv << ['All users', 'All movies', 'Unique movies', 'Popular movies']
          # body
          csv << [@dashboard.count_all_users, @dashboard.count_all_movies, @dashboard.count_unique_movies, @dashboard.popular_movies]
        end
        # send csv data to the browser
        send_data csv_data,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => 'attachment; filename=dashboard.csv'
      end
    end
  end
end
