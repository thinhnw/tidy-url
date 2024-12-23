require "test_helper"

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url = urls(:one)
  end

  test "should get index" do
    get urls_url
    assert_response :success
  end

  test "should get new" do
    get new_url_url
    assert_response :success
  end

  test "should create url" do
    assert_difference("Url.count", 1, "Url count should increase by 1") do
      assert_difference("Key.count", -1,  "Key count should decrease by 1") do
        post urls_url, params: { url: { original: "https://example.com" } }
      end
    end

    assert_redirected_to url_url(Url.last)
  end

  test "should show url" do
    get url_url(@url)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_url_url(@url)
  #   assert_response :success
  # end

  # test "should update url" do
  #   patch url_url(@url), params: { url: { original: @url.original, shortened: @url.shortened } }
  #   assert_redirected_to url_url(@url)
  # end

  test "should destroy url" do
    assert_difference("Url.count", -1) do
      delete url_url(@url)
    end

    assert_redirected_to urls_url
  end
end
