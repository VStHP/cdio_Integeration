class Ability
  include CanCan::Ability

  def initialize user
    if user.present?
      if user.admin?
        permitted_admin
      elsif user.trainer?
        permitted_trainer user
      else
        permitted_trainee user
      end
    end
  end

  def permitted_admin
    can :manage, [Course, Subject, Task, User, UserCourse, UserSubject]
  end

  def permitted_trainer user
    can :read, User
    can :new, User
    can :create, User do |u|
      u.trainee?
    end
    can :update, User do |u|
      u.trainee?
    end
    can :block_user, User do |u|
      u.trainee?
    end
    can :update, User, id: user.id
    can :manage, [Course, Subject, Task, UserCourse, UserSubject]
  end

  def permitted_trainee user
    can :read, Course do |c|
      user.courses.include? c
    end
    can :read, Subject
    can [:read, :update], UserTask do |ut|
      user.user_tasks.include? ut
    end
    can :read, User
    can :update, User, id: user.id
  end
end
