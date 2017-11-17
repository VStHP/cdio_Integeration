class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.suppervisor?
        can [:create, :new, :edit, :update, :destroy], Course
        can [:create, :new, :destroy], User
    end
  end
end
