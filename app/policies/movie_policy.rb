class MoviePolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def show?
    true
  end
end
