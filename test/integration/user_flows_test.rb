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

    assert_difference('Group.count') do
      post "/group/create", group: {name: 'COSI166B', year: 2016, term: 'Spring', section: 1, public: true}
    end
    assert_redirected_to homework_url

    assert_difference('Homework.count') do
      post "/homework/create", homework: {name: 'New hw', 'due_date(1i)' => 2016, 'due_date(2i)' => 5, 'due_date(3i)' => 16, 'due_date(4i)' => 12, 'due_date(5i)' => 30, group_id: 1}
    end
    assert_redirected_to homework_url

  end
end
