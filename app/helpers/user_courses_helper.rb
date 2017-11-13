module UserCoursesHelper

  def load_user user_course
    @user = User.find_by id: user_course.user_id
  end
end
