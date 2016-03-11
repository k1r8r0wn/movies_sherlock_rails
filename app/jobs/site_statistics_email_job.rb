class SiteStatisticsEmailJob
  @queue = :site_statistics_email_que

  def self.perform
    count_all_users = User.count
    count_all_movies = Movie.count
    count_unique_movies = Movie.uniq.count(:title)
    popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
    UserMailer.site_statistics_email(count_all_users, count_all_movies, count_unique_movies, popular_movies).deliver_now
  end
end
