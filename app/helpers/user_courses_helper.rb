module UserCoursesHelper

  def define_column list
    @quality = list.size / 5
    @quality += 1 unless list.size % 5 == 0
    @count = 0
  end

  def load_user user_course
    @user = User.find_by id: user_course.user_id
  end
end
