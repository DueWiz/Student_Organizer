require 'test_helper'

class CalendarControllerTest < ActionDispatch::IntegrationTest
  setup do
    https!
    get "/users/sign_in"
    post_via_redirect "/users/sign_in", 'user[email]' => 'user1@email.com', 'user[password]' => 'password'
  end

  test "should get index" do
    get calendar_index_url
    assert_response :success
  end

end
