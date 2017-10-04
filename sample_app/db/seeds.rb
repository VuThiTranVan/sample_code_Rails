User.create!(name: "Admin", email: "admin@gmail.com",
  password: "admin@", password_confirmation: "admin@", admin: true,
  activated: true, activated_at: Time.zone.now)
User.create!(name: "Van Vu", email: "vanvtt@gmail.com",
  password: "123123", password_confirmation: "123123", admin: false,
  activated: true, activated_at: Time.zone.now)
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123123"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, activated: true, activated_at: Time.zone.now)
end
# Adding microposts
users = User.order(:created_at).take(1)
6.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
