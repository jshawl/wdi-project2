# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tagging.destroy_all
Attendance.destroy_all
Following.destroy_all
Event.destroy_all
Location.destroy_all
Tag.destroy_all
User.destroy_all

User.create(username:"chase",email:"email@email.com",password:"password",gender:"m",preference:"f",dob:"3/1/1991")
100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    :email => Faker::Internet.email(first_name + "." + last_name),
    :password => Faker::Internet.password(8),
    :gender => ['m', 'f'].sample,
    :preference => ['m', 'f','b'].sample,
    :username => Faker::Internet.user_name(first_name + "." + last_name),
    :dob => Faker::Time.between(18.years.ago, 30.years.ago)
  )
end

50.times do
  Location.create(
    :address => "#{Faker::Address.street_address} Washington, DC",
    :name => Faker::Company.name,
    :latitude => (rand * (38.997235-38.840312) + 38.840312),
    :longitude => (rand * (77.1230767-76.9091637)-77.1230767)
  )
end

25.times do
  Event.create(
    :title => Faker::Book.title,
    :when => Faker::Time.between(1.days.ago, Time.now, :all),
    :location => Location.all.sample
  )
end

200.times do
  Tag.create(:tag => Faker::Lorem.word)
end

200.times do
  Tagging.create(
    :event => Event.all.sample,
    :tag => Tag.all.sample,
    :user => User.all.sample
    )
end

200.times do
  Attendance.create(
    :user => User.all.sample,
    :event => Event.all.sample
  )
end
