require "test_helper"

class BoxesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boxes_url
    assert_response :success
  end
end
