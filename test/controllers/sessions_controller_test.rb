require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sessions_show_url
    assert_response :success
  end

  test "should get index" do
    get sessions_index_url
    assert_response :success
  end

end
