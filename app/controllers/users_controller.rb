class UsersController < ApplicationController
  before_action :require_user, only: [:show, :my_movies]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit; end

  def show
    @all_users = User.count
    @all_movies = Movie.count
    @unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
    @user_movies = current_user.movies.count
    @movies_search = Movie.user_search(current_user).sum(:search_count)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, success: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User was successfully destroyed.'
  end

  def my_movies
    @user_movies = current_user.movies
  end

  private

  def set_user
    @user = User.find(params[:id])
    # redirect_to(root_url) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end
end
