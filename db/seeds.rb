
puts "destroying all rows"
Tagging.destroy_all
Attendance.destroy_all
Following.destroy_all
Event.destroy_all
Location.destroy_all
Tag.destroy_all
User.destroy_all

puts "Making 100 users plus me"
User.create(username:"chase",email:"email@email.com",password:"password",
      gender:"m",preference:"f",dob:"3/1/1991")
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
puts "Making 50 locations"
50.times do
  Location.create(
    :address => "#{Faker::Address.street_address}, Washington, DC",
    :name => Faker::Company.name,
    :latitude => (rand * (38.997235-38.840312) + 38.840312),
    :longitude => (rand * (77.1230767-76.9091637)-77.1230767)
  )
end
puts "Making 25 events"
25.times do
  Event.create(
    location:Location.all.sample,
    when:Faker::Time.between(1.days.ago, Time.now, :all),
    title:Faker::Book.title,
    owner:User.all.sample
  )
end
puts "Making 20 tags"
20.times do
  Tag.create(:tag => Faker::Lorem.word)
end
puts "Making 10 instances of tagging per user"
# 200.times do
User.all.each do |u|
  10.times do
    Tagging.create(
      :event => Event.all.sample,
      :tag => Tag.all.sample,
      :user => u
    )
  end
end
puts "Making 10 attendances per user"
User.all.each do |u|
  10.times do
    Attendance.create(
      :user => u,
      :event => Event.all.sample
    )
  end
end
puts "Making 400 followings"
400.times do
  follower = User.all.sample
  followed = User.all.sample
  Following.find_or_create_by(followed:followed,follower:follower)
end
puts "making each user vote"
User.all.each do |u|
  10.times do
    Event.all.sample.upvote_by u
  end
  4.times do
    Event.all.sample.downvote_by u
  end
end
