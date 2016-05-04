require 'test_helper'

class GroupControllerTest < ActionDispatch::IntegrationTest
    setup do
      @group = groups(:one)
      https!
      get "/users/sign_in"
      post_via_redirect "/users/sign_in", 'user[email]' => 'user1@email.com', 'user[password]' => 'password'
    end

    test "should get create" do
      assert_difference('Group.count') do
        post "/group/create", group: {name: 'COSI166B', year: 2016, term: 'Spring', section: 1, public: true}
      end
        assert_redirected_to homework_url
    end

    test "should get join" do
      assert_difference('GroupUser.count') do
        post "/group/join", group_id: @group.id
      end
      assert_redirected_to groupshow_path(@group)
    end

    test "should show group" do
      get groupshow_path(@group)
      assert_response :success
    end

    test "should get search" do
      get group_search_path, name: @group.name
      assert_response :success
    end
    # test "should get destroy" do
    #   assert_difference('GroupUser.count', -1) do
    #     post "/group/destroy", id: @group.id
    #   end
    #
    #   assert_redirected_to homework_url
    # end
end
