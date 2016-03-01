class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @all_users = User.count
    @all_movies = Movie.count
    @unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
    @user_movies = current_user.movies.count
    @movies_search = Movie.user_search(current_user).sum(:search_count)
  end

  def my_movies
    @user_movies = current_user.movies
  end
end
