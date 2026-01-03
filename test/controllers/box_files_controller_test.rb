require "test_helper"

class BoxFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post login_path, params: { username: "test", password: "foobar" }
    @box = boxes(:one)
    @box_file = box_files(:one)
  end

  test "show streams file inline" do
    get box_box_file_url(@box, @box_file)
    assert_response :success
    assert_equal "text/plain", @response.media_type
    assert_match /inline/, @response.headers["Content-Disposition"]
  end

  test "show with download param sets attachment disposition" do
    get box_box_file_url(@box, @box_file, download: true)
    assert_response :success
    assert_match /attachment/, @response.headers["Content-Disposition"]
  end

  test "destroy removes file and redirects to edit" do
    assert_difference("BoxFile.count", -1) do
      delete box_box_file_url(@box, @box_file)
    end
    assert_redirected_to edit_box_path(@box)
  end
end
