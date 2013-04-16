require 'test_helper'

class ApiUserRequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get accept" do
    get :accept
    assert_response :success
  end

  test "should get deny" do
    get :deny
    assert_response :success
  end

end
