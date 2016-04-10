# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Homework.delete_all
Group.delete_all
UserHomework.delete_all

user = User.create! :email => 'test@email.com', :password => 'topsecret', :password_confirmation => 'topsecret'
group = Group.create! :name => 'testgroup', :secteion => 1, :term =>'Spring', :year => 2016
GroupUser.create(user_id: user[:id], group_id: group[:id])
homework = Homework.create(name: 'testhomework', due_date: DateTime.new(2009,9,1,17),
  description: "this is the description for test",
  professor: "pito", group_id: group.id)
UserHomework.create(status: "done", grade: 100, comment: "this is comment", user_id: user[:id],
  homework_id: homework[:id], note: "this is note for test")
