module CoursesHelper
  def style_get arg
    case arg
    when "#"
      @style = "flex: 62 0 auto; width: 62px; max-width: 62px;"
    when "Course"
      @style = "flex: 300 0 auto; width: 300px; max-width: 300px;"
    when "Owner"
      @style = "flex: 150 0 auto; width: 150px; max-width: 150px;"
    when "Status"
      @style = "flex: 200 0 auto; width: 200px; max-width: 200px;"
    when "Organization"
      @style = "flex: 150 0 auto; width: 150px; max-width: 150px;"
    when "Program"
      @style = "flex: 250 0 auto; width: 250px; max-width: 250px;"
    else
      @style = "flex: 250 0 auto; width: 250px; max-width: 250px;"
    end
  end

  def owner_info course
    @owner = User.find_by id: course.users_id
    @owner ||= User.new
  end

  def select_owner_list
    @trainers = User.trainers
  end

  def org_hash
    @orgs = {DaNang: t("courses._orgs.dn"),
      HaNoi: t("courses._orgs.hn"),
      HoChiMinh: t("courses._orgs.hcm")}
  end

  def display_column_course_index
      %w(# Course Owner ) + Course.column_names -
      %w(id name description created_at updated_at users_id date_start)
  end

  def define_stt_index course
    case course.status
    when "init"
      @class = "cursor sttcourse sttcourse-init"
    when "in_progress"
      @class = "cursor sttcourse sttcourse-in-progress"
    when "in_progress"
      @class = "cursor sttcourse sttcourse-finish"
    else
      @class = "cursor sttcourse sttcourse-close"
    end
  end
end
