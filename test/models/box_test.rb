require "test_helper"

class BoxTest < ActiveSupport::TestCase
  test "#unpack" do
    box = Box.find(0)
    assert_equal 0, Action.where(box_id: box.id).count

    box.unpack

    assert_equal 1, Action.where(box_id: box.id).count
  end

  test "#unpack_action" do
    box = Box.find(0)
    a1 = Action.create(name: "unrelated_action", box:, user: "test #unpack_action")
    a2 = Action.create(name: Action.unpack, box:, user: "test #unpack_action")

    assert_equal a2, box.unpack_action
  end

  test "#unpacked?" do
    box = Box.find(0)
    Action.create(name: Action.unpack, box:, user: "test #unpacked?")

    assert box.unpacked?
  end

  test ".next_number (no existing boxes)" do
    Box.destroy_all
    assert_equal 1, Box.next_number
  end

  test ".next_number" do
    assert_equal 3, Box.next_number
  end
end
