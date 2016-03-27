class MoviePolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def all
    true
  end

  def add_video?
    user.admin?
  end

  alias_method :show?, :all
  alias_method :vote_for?, :all
  alias_method :vote_against?, :all
  alias_method :unvote?, :all
  alias_method :search?, :all
end
