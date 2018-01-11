User.create!(name: "Admin", email: "admin@gmail.com", password: "123123",
     password_confirmation: "123123", gender: "male", date_start: Time.zone.today-20,
     university: "DUY TAN UNIVERSITY",program: "Manage of IT stCompany Education", suppervisor: 2)

1.upto(5) do |x|
  name = Faker::Name.name
  email = "trainee#{x}@gmail.com"
  password = "123123"
  password_confirmation = "123123"
  gender = rand(1<<1)
  date_start = Faker::Date.between(7.months.ago, 2.months.ago)
  university = Faker::University.name
  program = "Intership"
  suppervisor = 0
  User.create!(name: name, email: email, password: password,
     password_confirmation: password_confirmation, gender: gender, date_start: date_start,
     university: university,program: program, suppervisor: suppervisor)
end

1.upto(10) do |x|
  name = Faker::Name.name
  email = "trainer#{x}@stcompany.com"
  password = "123123"
  password_confirmation = "123123"
  gender = rand(1<<1)
  date_start = Faker::Date.between(2.years.ago, 5.months.ago)
  university = Faker::University.name
  program = "Human Education - IT stCompany"
  suppervisor = 1
  User.create!(name: name, email: email, password: password,
     password_confirmation: password_confirmation, gender: gender, date_start: date_start,
     university: university,program: program, suppervisor: suppervisor)
end

# 1.upto(20) do |x|
#   name = Faker::Educator.course << " - SS #{x}"
#   description = "This course had been created to training Ruby on Rails !"
#   owner = "#{51+x}"
#   program = "Open Education in Da Nang"
#   training_standard = "Ruby Open Education training"
#   date = Faker::Date.between(7.months.ago, Time.zone.today + 60)
#   if date < Time.zone.today
#     status = "block"
#   else
#     status = "init"
#   end
#   Course.create!(name: name, description: description, status: status, users_id: owner, program: program, training_standard: training_standard, date_start: date)
# end

# 1.upto(20) do
#   name = Faker::ProgrammingLanguage.name << " Tutorial"
#   description = "This is description of Subject"
#   teacher = Faker::ProgrammingLanguage.creator
#   times = rand(8) + 2
#   Subject.create!(name: name, description: description, teacher: teacher, time: times)
# end
