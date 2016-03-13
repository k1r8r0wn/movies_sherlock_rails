class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def show
    authorize :user, :show?
    @count_user_movies = current_user.movies.count
    @count_movies_search = Movie.user_search(current_user).sum(:search_count)
  end

  def my_movies
    authorize :user, :my_movies?
    @count_user_movies = current_user.movies.count
    if params[:id]
      @user_movies = current_user.movies.where('id < ?', params[:id]).limit(3)
    else
      @user_movies = current_user.movies.limit(3)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
