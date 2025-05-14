require "test_helper"

class ExhibitTest < ActiveSupport::TestCase
  test "should not be valid without a user" do
    exhibit = Exhibit.new(name: "Test Exhibit")
    assert_not exhibit.valid?
    assert_includes exhibit.errors[:user], "must exist"
  end

  test "should not be valid without artists" do
    exhibit = Exhibit.new(name: "Test Exhibit")
    assert_not exhibit.valid?
    assert_includes exhibit.errors[:artists], "can't be blank"
  end
end
