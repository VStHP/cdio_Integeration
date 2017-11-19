class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :read, :all
      can :manage, Course
      can :manage, User
    elsif user.trainer?
      can :read, :all
      can :manage, Course
      can :manage, User
    else
      can :read, :all
    end
  end
end
