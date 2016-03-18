class UserPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def all
    true
  end

  alias_method :show?, :all
  alias_method :my_movies?, :all
end
