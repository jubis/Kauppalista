require 'test_helper'

class ItemControllerTest < ActionController::TestCase
  test "should get save" do
    get :save
    assert_response :success
  end

end
