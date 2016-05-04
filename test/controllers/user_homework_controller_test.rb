require 'test_helper'

class UserHomeworkControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userhw = user_homeworks(:one)
    @homework = homeworks(:one)
    https!
    get "/users/sign_in"
    post_via_redirect "/users/sign_in", 'user[email]' => 'user1@email.com', 'user[password]' => 'password'
  end



end
