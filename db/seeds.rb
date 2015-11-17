# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'faker'

Tagging.destroy_all
Attendance.destroy_all
Following.destroy_all
Event.destroy_all
Location.destroy_all
Tag.destroy_all
User.destroy_all



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
    :name => Faker::Company.name
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


# u1 = User.create(email:"test@email.com",password:"password",gender:"m",preference:"f",username:"test_guy",dob:"3/1/1989")
# u2 = User.create(email:"test2@email.com",password:"password",gender:"f",preference:"m",username:"test_gal",dob:"5/29/1992")
# u3 = User.create(email:"test3@email.com",password:"password",gender:"f",preference:"m",username:"test_girl",dob:"9/9/1985")

# l = Location.create(address:"2501 Porter St NW, Washington, DC", name:"My House")
# l2 = Location.create(address:"1600 Pennsylvania Ave, Washington DC",name:"Cool Bar")
# e = Event.create(title:"my birthday", when:"9:30pm",location:l)
# e2 = Event.create(title:"doin stuff", when:"3:00am",location:l2)
#
# t1 = Tag.create(tag:"Banger")
# t2 = Tag.create(tag:"Terrifying")
# t3 = Tag.create(tag:"Burgers")
#
# Tagging.create(event:e,tag:t1, user:u1)
# Tagging.create(event:e,tag:t3, user:u2)
# Tagging.create(event:e2,tag:t2,user:u3)
# Tagging.create(event:e2,tag:t3,user:u1)
#
# Attendance.create(user:u1,event:e)
# Attendance.create(user:u2,event:e)
# Attendance.create(user:u1,event:e2)
# Attendance.create(user:u3,event:e2)
