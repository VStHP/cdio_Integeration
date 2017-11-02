1.upto(10) do |x|
  name = Faker::Name.name
  email = "trainee#{x}@gmail.com"
  password = "123123"
  password_confirmation = "123123"
  gender = rand(1<<1)
  date_start = Faker::Date.between(10.days.ago, Date.today)
  university = Faker::University.name
  program = "Ruby Intership"
  suppervisor = false
  User.create!(name: name, email: email, password: password,
     password_confirmation: password_confirmation, gender: gender, date_start: date_start,
     university: university,program: program, suppervisor: suppervisor)
end

1.upto(10) do |x|
  name = Faker::Name.name
  email = "trainer#{x}@gmail.com"
  password = "123123"
  password_confirmation = "123123"
  gender = rand(1<<1)
  date_start = Faker::Date.between(10.days.ago, Date.today)
  university = Faker::University.name
  program = "Ruby Intership"
  suppervisor = true
  User.create!(name: name, email: email, password: password,
     password_confirmation: password_confirmation, gender: gender, date_start: date_start,
     university: university,program: program, suppervisor: suppervisor)
end
