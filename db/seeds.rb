# User.create!(name: "Admin", email: "admin@gmail.com", password: "123123",
#      password_confirmation: "123123", gender: "male", date_start: Time.zone.today-20,
#      university: "Admin",program: "Manage this website", suppervisor: 2)

# 1.upto(10) do |x|
#   name = Faker::Name.name
#   email = "trainee#{x}@gmail.com"
#   password = "123123"
#   password_confirmation = "123123"
#   gender = rand(1<<1)
#   date_start = Faker::Date.between(10.days.ago, Date.today)
#   university = Faker::University.name
#   program = "Ruby Intership"
#   suppervisor = 0
#   User.create!(name: name, email: email, password: password,
#      password_confirmation: password_confirmation, gender: gender, date_start: date_start,
#      university: university,program: program, suppervisor: suppervisor)
# end

# 1.upto(10) do |x|
#   name = Faker::Name.name
#   email = "trainer#{x}@gmail.com"
#   password = "123123"
#   password_confirmation = "123123"
#   gender = rand(1<<1)
#   date_start = Faker::Date.between(10.days.ago, Date.today)
#   university = Faker::University.name
#   program = "Ruby Intership"
#   suppervisor = 1
#   User.create!(name: name, email: email, password: password,
#      password_confirmation: password_confirmation, gender: gender, date_start: date_start,
#      university: university,program: program, suppervisor: suppervisor)
# end

1.upto(10) do |x|
  name = "Open Training Course Seasion #{x}"
  description = "This course had been created to training Ruby on Rails !"
  status = "init"
  owner = "1#{x}"
  program = "Open Education in Da Nang"
  training_standard = "Ruby Open Education training"
  date = Faker::Date.between((700-x*60).days.ago, (700-x*60).days.ago)
  Course.create!(name: name, description: description, status: status, users_id: owner, program: program, training_standard: training_standard, date_start: date)
end

1.upto(6) do |x|
  user_id = 11
  course_id = x
  status = "init"
  date_start = Time.zone.now
  UserCourse.create!(user_id: user_id, course_id: course_id, status: status)
end

arr = ["Git","Ruby","Ruby on rails 5","Scrum","PHP","Android"]
5.times do |x|
  name = arr[x]+" Tutorial"
  description = "This is description of Subject"
  Subject.create!(name: name, description: description)
end
