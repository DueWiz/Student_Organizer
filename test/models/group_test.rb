require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  it "has two groups in database" do
    Group.count.must_equal 2
  end

  it "can accept a new group" do
    Group.create(name: "G3", year: 2016, term: "Spring", section: 1)
    Group.count.must_equal 3
  end

  it "can delete an existing group" do
    g = Group.create(name: "G3", year: 2016, term: "Spring", section: 1)
    Group.count.must_equal 3
    n = g.id
    Group.delete(n)
    Group.count.must_equal 2
  end

  it "cannot save a group without the a name" do
    w = Group.create()
    w.valid?.must_equal false
  end

  it "group name has to be unique" do
    g = Group.create(name: "G2")
    assert_not g.valid?
  end

end
