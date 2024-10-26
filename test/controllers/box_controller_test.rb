require "test_helper"

class BoxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get box_index_url
    assert_response :success
  end
end
