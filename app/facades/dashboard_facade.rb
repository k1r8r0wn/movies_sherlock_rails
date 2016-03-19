class DashboardFacade
  def count_all_users
    User.count
  end

  def count_all_movies
    Movie.count
  end

  def count_unique_movies
    Movie.uniq.count(:title)
  end

  def popular_movies
    Movie.group(:title).sum(:search_count).sort_by { |_key, values| - values}.first(5)
  end

  def csv_prepare
    popular_movies.map do |movie, times|
      "#{movie} - #{times} time(-s)"
    end.join(', ')
  end
end
