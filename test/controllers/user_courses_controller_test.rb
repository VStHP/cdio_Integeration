require 'test_helper'

class UserCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_courses_index_url
    assert_response :success
  end

end
