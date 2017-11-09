class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.suppervisor?
        can [:create, :new, :edit, :update, :destroy], Course
    end
  end
end
