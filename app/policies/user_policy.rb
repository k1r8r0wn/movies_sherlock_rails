class UserPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def show?
    true
  end

  def my_movies?
    true
  end
end
