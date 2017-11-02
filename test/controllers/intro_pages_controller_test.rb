require 'test_helper'

class IntroPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get intro_pages_home_url
    assert_response :success
  end

end
