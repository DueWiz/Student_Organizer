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

user = User.create! :email => 'zheng@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
group = Group.create(name: "cosi166")
homework = Homework.create(name: "maze", due_date: DateTime.new(2001,-11,-26,-20,-55,-54,'+7'), description: "this is the desp",
  professor: "pito", group_id: group.id)
UserHomework.create(status: "done", grade: 100, comment: "good job", user_id: user.id,
  homework_id: homework.id, note: "this is note")
