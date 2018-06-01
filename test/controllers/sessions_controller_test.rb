require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
  #routes to login
    get login_path
    assert_response :success
  end

end
