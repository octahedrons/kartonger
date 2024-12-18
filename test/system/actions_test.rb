require "application_system_test_case"

class ActionsTest < ApplicationSystemTestCase
  setup do
    visit boxes_url
    fill_in "username", with: "test"
    fill_in "password", with: "foobar"
    click_on :commit
  end

  test "mark box as unpacked" do
    box = Box.first
    assert_not box.unpacked?

    checkbox = "box-action-#{box.id}"
    check checkbox

    assert_checked_field checkbox
    assert Box.find(box.id).unpacked?
  end

  test "unmark box as unpacked" do
    # setup
    box = Box.first
    box.unpack(user: "test case 'unmark box as unpacked'")
    assert Box.find(box.id).unpacked?

    visit boxes_url
    checkbox = "box-action-#{box.id}"
    assert_checked_field checkbox

    uncheck checkbox

    assert_unchecked_field checkbox
    assert_not Box.find(box.id).unpacked?
  end
end
