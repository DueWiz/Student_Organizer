require 'test_helper'

class GroupUserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  it "has three GroupUser in database" do
    GroupUser.count.must_equal 3
  end

  it "can accept a new GroupUser" do
    GroupUser.create(group_id: 1, user_id: 2)
    GroupUser.count.must_equal 4
  end

  it "can delete an existing GroupUser" do
    h = GroupUser.create(group_id: 1, user_id: 2)
    GroupUser.count.must_equal 4
    n = h.id
    GroupUser.delete(n)
    GroupUser.count.must_equal 3
  end

  it "cannot save a hw without a group_id or user_id" do
    w = GroupUser.create(group_id: 1)
    w.valid?.must_equal false
    w = GroupUser.create(user_id: 2)
    w.valid?.must_equal false
  end
end
