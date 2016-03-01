class UserPolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user  = user
    @movie = movie
  end

  def show?
    user.user? || user.admin?
  end

  def my_movies?
    user.user? || user.admin?
  end

  def site_statistics?
    user.admin?
  end
end
