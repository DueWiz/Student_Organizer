require 'test_helper'

class UserHomeworkTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  it "has two UserHomework in database" do
    UserHomework.count.must_equal 2
  end

  it "can accept a new UserHomework" do
    UserHomework.create(user_id: 1, homework_id: 2)
    UserHomework.count.must_equal 3
  end

  it "can delete an existing UserHomework" do
    h = UserHomework.create(user_id: 1, homework_id: 2)
    UserHomework.count.must_equal 3
    n = h.id
    UserHomework.delete(n)
    UserHomework.count.must_equal 2
  end

  it "cannot save a UserHomework without the a user_id or homework_id" do
    w = UserHomework.create(user_id: 1)
    w.valid?.must_equal false
    w = UserHomework.create(homework_id: 2)
    w.valid?.must_equal false
  end
end
