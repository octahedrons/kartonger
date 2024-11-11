require "test_helper"

class BoxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post login_path, params: { username: "test", password: "foobar" }
  end

  test "view boxes" do
    get boxes_url
    assert_response :success
  end

  test "create the first box" do
    Box.destroy_all
    get new_box_url
    assert_response :success
  end

  test "create box" do
    get new_box_url
    assert_response :success
  end
end
