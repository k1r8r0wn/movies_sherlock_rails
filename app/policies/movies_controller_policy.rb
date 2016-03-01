class MoviesControllerPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def show?
    user.user? || user.admin?
  end
end
