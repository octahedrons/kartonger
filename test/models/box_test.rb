require "test_helper"

class BoxTest < ActiveSupport::TestCase
  test ".next_number (no existing boxes)" do
    Box.destroy_all
    assert_equal 1, Box.next_number
  end

  test ".next_number" do
    assert_equal 3, Box.next_number
  end
end
