require "test_helper"

class BoxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post login_path, params: { username: "test", password: "foobar" }
  end

  test "view boxes" do
    get boxes_url
    assert_response :success
  end

  test "view boxes without values" do
    Box.create
    get boxes_url
    assert_response :success
  end

  test "export boxes" do
    test_time = Time.utc(2024, 11, 11, 23, 7, 1)
    travel_to(test_time) do
      get boxes_url format: :csv
      assert_response :success
      assert_match /Cheese & Crackers/, @response.body
      assert_match /PC LOAD LETTER/, @response.body
      assert_no_match /^\n*$/, @response.body # no blank lines
      assert_equal "text/csv", @response.media_type
      assert_equal \
        "attachment; filename=boxes_2024-11-11T23:07:01Z.csv",
        @response.headers["content-disposition"]
    end
  end

  test "create the first box" do
    Box.destroy_all
    get new_box_url
    assert_response :success
  end

  test "create box" do
    post boxes_url, params: { box: { number: 3, room: Box.rooms.sample, packed_by: "packer",  } }
    assert_response :redirect
    assert_equal "packer", Box.find_by(number: 3).packed_by
  end

  test "create box without selecting room" do
    post boxes_url, params: { box: { number: 3, room: "Välj...", packed_by: "packer" } }
    assert_response :unprocessable_content
    assert_nil Box.find_by(number: 3)
  end
end
