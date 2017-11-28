class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :read, :all
      can :manage, Course
      can :manage, User
      can :manage, Subject
      can :manage, Task
      can :manage, CourseSubject
    elsif user.trainer?
      can :read, :all
      can :manage, Course
      can :manage, User
      can :manage, Subject
      can :manage, Task
      can :manage, CourseSubject
    else
      can :update, User, user_id: user.id
      can :read, :all
    end
  end
end
