require "test_helper"

class ActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post login_path, params: { username: "test", password: "foobar" }
  end

  test "view actions" do
    get actions_url
    assert_response :success
  end

  test "create action" do
    action_name = "some_action"
    box = Box.first
    post box_actions_path(box.id), params: { action_name:, user: "Jane Doe" }

    assert_response :redirect
    assert_equal 1, Action.where(box: box, name: action_name).count
  end

  test "delete action" do
    # ensure we have unrelated actions in the system
    Action.create(name: "unrelated_action", box: Box.find(1))
    assert_equal 1, Action.count

    action_name = "some_action"
    box = Box.find(0)
    action = Action.create(box:, name: action_name)
    assert_equal 2, Action.count
    assert_equal 1, Action.where(box: box, name: action_name).count

    delete box_action_path(box.id, action.id)

    assert_response :see_other
    assert_equal 1, Action.count
  end
end
