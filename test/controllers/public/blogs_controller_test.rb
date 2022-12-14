require "test_helper"

class Public::BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_blogs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_blogs_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_blogs_edit_url
    assert_response :success
  end
end
