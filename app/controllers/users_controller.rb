class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :authorize_user
  after_action :verify_authorized

  def show
    @user_movies = current_user.movies.count
    @movies_search = Movie.user_search(current_user).sum(:search_count)
  end

  def my_movies
    @user_movies = current_user.movies
  end
end
