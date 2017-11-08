require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get courses_index_url
    assert_response :success
  end

  test "should get show" do
    get courses_show_url
    assert_response :success
  end

  test "should get update" do
    get courses_update_url
    assert_response :success
  end

  test "should get new" do
    get courses_new_url
    assert_response :success
  end

end
