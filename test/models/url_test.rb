require "test_helper"

class UrlTest < ActiveSupport::TestCase
  test "should save valid URL" do
    url = Url.new(original: "http://example.com", shortened: "short")
    assert url.save, "Failed to save a valid URL"
  end

  test "should not save URL without original" do
    url = Url.new(shortened: "short")
    assert_not url.save, "Saved the URL without original"
    assert_includes url.errors[:original], "can't be blank"
  end

  test "should not save URL without shortened" do
    url = Url.new(original: "http://example.com")
    assert_not url.save, "Saved the URL without shortened"
    assert_includes url.errors[:shortened], "can't be blank"
  end

  test "should not save URL with duplicate shortened" do
    Url.create(original: "http://example1.com", shortened: "short")
    url = Url.new(original: "http://example2.com", shortened: "short")
    assert_not url.save, "Saved the URL with duplicate shortened"
    assert_includes url.errors[:shortened], "has already been taken"
  end

  test "should not save URL with invalid original" do
    invalid_urls = [
      "not-a-url",            # No scheme
      "ftp://example.com",    # Unsupported scheme
      "http//example.com",    # Malformed scheme
      "http://",              # Missing host
      "example.com",          # Missing scheme
      "http:// example.com"  # Space in URL
    ]
    invalid_urls.each do |invalid_url|
      url = Url.new(original: invalid_url, shortened: "short")
      assert_not url.save, "Saved the URL with an invalid original: #{invalid_url}"
      assert_includes url.errors[:original], "must be a valid URL"
    end
  end
end
