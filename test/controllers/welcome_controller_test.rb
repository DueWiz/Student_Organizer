require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    https!
    get "/users/sign_in"
    post_via_redirect "/users/sign_in", 'user[email]' => 'user1@email.com', 'user[password]' => 'password'
    get welcome_index_url
    assert_response :success
  end

end
