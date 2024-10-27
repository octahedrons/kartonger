require "test_helper"

class BoxesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post login_path, params: { username: "test", password: "foobar" }
    get boxes_url
    assert_response :success
  end
end
