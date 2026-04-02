require "test_helper"

class HelpControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get help_url
    assert_response :success
  end
end
