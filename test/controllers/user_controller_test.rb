require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get registeration" do
    get :registeration
    assert_response :success
  end

end
