module UsersHelper

  def display_column_user_index
      %w(# Name Email University Program DateStart )
  end

  def style_get arg
    case arg
    when "#"
      @style = "flex: 62 0 auto; width: 62px; max-width: 62px;"
    when "Name"
      @style = "flex: 200 0 auto; width: 200px; max-width: 200px;"
    when "Email"
      @style = "flex: 200 0 auto; width: 200px; max-width: 200px;"
    when "University"
      @style = "flex: 200 0 auto; width: 200px; max-width: 200px;"
    when "Program"
      @style = "flex: 200 0 auto; width: 200px; max-width: 200px;"
    when "DateStart"
      @style = "flex: 80 0 auto; width: 80px; max-width: 80px;"
    end
  end

  def show_avatar_for user
    image_tag(user.avatar.url, class: "img-circle img-responsive", id: "avatar_image")
  end

  def month_name int
    case int
    when 1
      "Jan"
    when 2
      "Feb"
    when 3
      "Mar"
    when 4
      "Apr"
    when 5
      "May"
    when 6
      "Jun"
    when 7
      "Jul"
    when 8
      "Aug"
    when 9
      "Sep"
    when 10
      "Oct"
    when 11
      "Nov"
    else
      "Dec"
    end
  end
end
