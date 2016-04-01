require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "login and browse site" do
    # login via https
    user = User.create(:password => '12345678', :password_confirmation => '12345678', :email => 'foo@bar.com')
    user.save!


    https!
    get "/users/sign_in"
    assert_response :success

    post_via_redirect "/users/sign_in", 'user[email]' => 'foo@bar.com', 'user[password]' => '12345678'
    assert_equal '/', path
    # assert_equal 'Welcome david!', flash[:notice]
    #
    https!(false)
    get "/homework"
    assert_response :success

  end
end
