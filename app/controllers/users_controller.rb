class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def show
    authorize :user, :show?
    @count_user_movies = current_user.movies.count
    @total_search_count = current_user.total_search_count
  end

  def my_movies
    authorize :user, :my_movies?
    @user_movies = current_user.movies.order('created_at DESC').page(params[:page]).per(5)
  end
end
