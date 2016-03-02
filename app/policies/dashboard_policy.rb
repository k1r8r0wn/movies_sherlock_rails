class DashboardPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user  = user
    @model = model
  end

  def index?
    user.admin?
  end
end
