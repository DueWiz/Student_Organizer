require 'test_helper'

class LatteControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get latte_create_url
    assert_response :success
  end

end
