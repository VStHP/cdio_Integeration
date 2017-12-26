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
    can :create, User, suppervisor: "trainee"
    can :update, User do |u|
      u.id == user.id || u.trainee?
    end
    can :manage, :all
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
