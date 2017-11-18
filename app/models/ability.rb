class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
        can [:create, :new, :edit, :update, :destroy], Course
        can [:create, :new, :destroy], User
    else
      can :read, :all
    end
  end
end
