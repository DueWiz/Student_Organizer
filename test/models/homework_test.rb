require 'test_helper'

class HomeworkTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  it "has two hws in database" do
    Homework.count.must_equal 2
  end

  it "can accept a new hw" do
    Homework.create(name: "HW3", due_date: "2016-01-24 20:59:29")
    Homework.count.must_equal 3
  end

  it "can delete an existing hw" do
    h = Homework.create(name: "Hw3", due_date: "2016-01-24 20:59:29")
    Homework.count.must_equal 3
    n = h.id
    Homework.delete(n)
    Homework.count.must_equal 2
  end

  it "cannot save a hw without the a name or due_date" do
    w = Homework.create(name: "hw4")
    w.valid?.must_equal false
    w = Homework.create(due_date: "2016-01-24 20:59:29")
    w.valid?.must_equal false
  end
end
