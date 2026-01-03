require "test_helper"

class BoxFileTest < ActiveSupport::TestCase
  test "belongs to box" do
    box_file = BoxFile.new(
      box_id: 0,
      filename: "test.txt",
      content_type: "text/plain",
      data: "content"
    )
    assert box_file.valid?
  end

  test "requires filename" do
    box_file = BoxFile.new(box_id: 0, content_type: "text/plain", data: "content")
    assert_not box_file.valid?
    assert_includes box_file.errors[:filename], "can't be blank"
  end

  test "requires content_type" do
    box_file = BoxFile.new(box_id: 0, filename: "test.txt", data: "content")
    assert_not box_file.valid?
    assert_includes box_file.errors[:content_type], "can't be blank"
  end

  test "requires data" do
    box_file = BoxFile.new(box_id: 0, filename: "test.txt", content_type: "text/plain")
    assert_not box_file.valid?
    assert_includes box_file.errors[:data], "can't be blank"
  end

  test "#image? returns true for image content types" do
    box_file = BoxFile.new(content_type: "image/png")
    assert box_file.image?

    box_file.content_type = "image/jpeg"
    assert box_file.image?
  end

  test "#image? returns false for non-image content types" do
    box_file = BoxFile.new(content_type: "text/plain")
    assert_not box_file.image?

    box_file.content_type = "application/pdf"
    assert_not box_file.image?
  end

  test "#image? returns false for nil content_type" do
    box_file = BoxFile.new(content_type: nil)
    assert_not box_file.image?
  end
end
