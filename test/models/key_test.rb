require "test_helper"

class KeyTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    key = Key.new
    assert_not key.save
  end
  test "should validate uniqueness of name" do
    key = Key.new(name: "oneone")
    assert_not key.save
  end
end
