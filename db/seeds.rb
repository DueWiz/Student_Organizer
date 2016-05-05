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
LatteAccount.delete_all
GroupUser.delete_all

user = User.create! :email => 'yiran@email.com', :password => '12345678', :password_confirmation => '12345678'
group1 = Group.create! :name => 'Operating System', :section => 2, :term =>'Spring', :year => 2016, :public => true
group2 = Group.create! :name => 'Programming', :section => 1, :term =>'Spring', :year => 2016, :public =>true
GroupUser.create(user_id: user[:id], group_id: group1[:id])
GroupUser.create(user_id: user[:id], group_id: group2[:id])
homework1 = Homework.create(name: 'Problem Set 5: File Systems and Trasactions', due_date: Time.now.to_datetime,
  description: "Please solve the following problems from S&G 7th edition with Java:
Chapter 10, Problems 2,6
Chapter 11: Problems 3(a,b), 4, 10
Chapter 21: Please read sections 21.7.1-3 from Linux Case study.
Explain briefly why a journalling file system that logs file metadata
can improve overall file system performance, compared to a file system without a log (in addition to shortening recovery time).",
  professor: "Liuba Shrira", group_id: group1.id)
homework2 = Homework.create(name: 'Quiz 3 Topics', due_date: Time.now.to_datetime,
    description: "A. Memory Management Chapters 8, and Chapter 9 (sec 1-6) and 9.10
Protection:
 Kernel vs user mode, what is address space, how is it implemented using address translation.
Address translation and memory allocation
 options for managing memory: paging, segmentation, multilevel translation,
 paged page tables, comparison among options
 caching applied to address translation: TLB
 memory hierarchy, generic issues in caching: temporal and spatial locality
  cache hit, cache miss: compulsory, capacity and conflict miss",
    professor: "Liuba Shrira", group_id: group1.id)
UserHomework.create(status: "No attempt", grade: 0, comment: "Please finish this homework", user_id: user[:id],
  homework_id: homework1[:id], note: "try to finish this homework ealier")
UserHomework.create(status: "No attempt", grade: 0, comment: "review for the quiz", user_id: user[:id],
    homework_id: homework2[:id], note: "find some time go through the list")

homework3 = Homework.create(name: 'HW10', due_date: Time.now.to_datetime,
        description: "Complete the End of Unit 4 Student Survey to self-assess your learning in this unit and our pedagogical offerings

https://docs.google.com/a/brandeis.edu/forms/d/1gEjXzpw5ymAG3YAfNUzXqs27olNDN0bX0eL7B7kMvPA/viewform",
        professor: "Tim Hickey", group_id: group2.id)
homework4 = Homework.create(name: 'HW11', due_date: Time.now.to_datetime,
                description: "This is computed from the percentage of iResponder questions answered.

There were 86 iResponder questions for section 1 and if you answered n of the questions,

then we calculate the participation grade as  min(n,43)/43*10

So if you answered over half of the questions you get 10 points, which is 100% of the participation grade

If you answered under half of the questions you get whatever percent of those 43 you answered.

It doesn't matter if you answered correctly or not, just participating is all we counted.

So if you answered 21 questions you would get 5/10 points for participation",
                professor: "Tim Hickey", group_id: group2.id)
UserHomework.create(status: "No attempt", grade: 0, comment: "Please finish this homework", user_id: user[:id],
                  homework_id: homework3[:id], note: "try to finish this homework ealier")
UserHomework.create(status: "No attempt", grade: 0, comment: "Finish this one later", user_id: user[:id],
                    homework_id: homework4[:id], note: "meet with prof before finish this one")
