require 'test_helper'

class UserHomeworkControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_homework_index_url
    assert_response :success
  end

end
