User.create!(name: "Admin", email: "admin@gmail.com",
  password: "admin@", password_confirmation: "admin@", admin: true)
User.create!(name: "Van Vu", email: "vanvtt@gmail.com",
  password: "123123", password_confirmation: "123123", admin: false)
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123123"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end
