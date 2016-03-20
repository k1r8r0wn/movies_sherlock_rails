class SiteStatisticsEmailJob
  @queue = :site_statistics_email_que

  def self.perform
    dashboard = DashboardFacade.new
    count_all_users = dashboard.count_all_users
    count_all_movies = dashboard.count_all_movies
    popular_movies = dashboard.popular_movies
    low_voted_movies = dashboard.low_voted_movies
    top_voted_movies = dashboard.top_voted_movies
    UserMailer.site_statistics_email(count_all_users, count_all_movies, popular_movies, low_voted_movies, top_voted_movies).deliver_now
  end
end
