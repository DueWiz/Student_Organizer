require 'test_helper'

class HomeworkControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # test "should get index" do
  #   get root_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get homework_new_url
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get homework_edit_url
  #   assert_response :success
  # end
  #
  # test "should get create" do
  #   get homework_create_url
  #   assert_response :success
  # end
  setup do
    @homework = homeworks(:one)
    https!
    get "/users/sign_in"
    post_via_redirect "/users/sign_in", 'user[email]' => 'user1@email.com', 'user[password]' => 'password'
  end

  test "should get create" do
    assert_difference('Homework.count') do
      post "/homework/create", homework: {name: 'New hw', 'due_date(1i)' => 2016, 'due_date(2i)' => 5, 'due_date(3i)' => 16, 'due_date(4i)' => 12, 'due_date(5i)' => 30, group_id: 1}
    end
      assert_redirected_to homework_url
  end


  test "should show homework" do
    get homeworkshow_path(@homework)
    assert_response :success
  end
>>>>>>> sylarLu
  #
  test "should get update" do
    get homeworkupdate_path(@homework)
    assert_response :success
  end

  test "should get edit" do
    get homeworkedit_path(@homework), homework: {name: 'Edit hw', 'due_date(1i)' => 2016, 'due_date(2i)' => 6, 'due_date(3i)' => 17, 'due_date(4i)' => 10, 'due_date(5i)' => 30, group_id: 1}
    assert_redirected_to homeworkshow_path(@homework)
  end

  test "should get delete" do
    assert_difference('UserHomework.count', -1) do
      get homeworkdestroy_path(@homework)
    end
    assert_redirected_to homework_url
  end

  #
  # test "should get destroy" do
  #   get homework_destroy_url
  #   assert_response :success
  # end

end
