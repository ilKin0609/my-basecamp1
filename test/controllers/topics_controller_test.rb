require "test_helper"

class TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get topics_create_url
    assert_response :success
  end

  test "should get destroy" do
    get topics_destroy_url
    assert_response :success
  end
end
