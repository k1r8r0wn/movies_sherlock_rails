class DashboardFacade
  def count_all_users
    User.count
  end

  def count_all_movies
    Movie.count
  end

  def popular_movies
    Movie.group(:title).sum(:search_count).sort_by { |_key, values| - values}.first(5)
  end

  def low_voted_movies
    Movie.tally.limit(5).having('COUNT(votes.id) < 5').to_a.map{|x| x['title']}.uniq
  end

  def top_voted_movies
    Movie.tally.limit(5).having('COUNT(votes.id) > 5').to_a.map{|x| x['title']}.uniq
  end

  def csv_popular_movies
    popular_movies.map do |movie, times|
      "#{movie} - #{times} time(-s)"
    end.join(', ')
  end

  def csv_low_voted_movies
    low_voted_movies.map do |movie|
      "#{movie}"
    end.join(', ')
  end

  def csv_top_voted_movies
    unless top_voted_movies.empty?
      top_voted_movies.map do |movie|
        "#{movie}"
      end.join(', ')
    end
  end
end
