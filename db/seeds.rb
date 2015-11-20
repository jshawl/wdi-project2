
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
20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    :email => Faker::Internet.email(first_name + "." + last_name),
    :password => "password",#Faker::Internet.password(8),
    :gender => ['m', 'f'].sample,
    :preference => ['m', 'f','b'].sample,
    :username => Faker::Internet.user_name,
    :dob => Faker::Time.between(18.years.ago, 30.years.ago)
  )
end
puts "Making locations"
Location.create([{:name => "The Gibson", :address => "2009 14th St NW, Washington DC"},{:name => "Off the Record", :address => "800 16th St NW, Washington DC"},{:name => "Penn Social", :address => "801 E St NW, Washington DC"},{:name => "Nanny O'Briens", :address => "3319 Connecticut Ave NW, Washington DC"},{:name => "Smoke and Barrel", :address => "2471 18th St NW, Washington DC"},{:name => "Biergarten Haus", :address => "1355 H St NE, Washington DC"},{:name => "DC9", :address => "1940 9th St, Washington DC"},{:name => "Meridian Pint", :address => "3400 11th St NW, Washington DC"},{:name => "Wonderland Ballroom", :address => "1101 Kenyon St NW, Washington DC"},{:name => "Marvin", :address => "2007 14th St NW, Washington DC"}])
# 50.times do
#   Location.create(
#     :address => "#{Faker::Address.street_address}, Washington, DC",
#     :name => Faker::Company.name,
#     :latitude => (rand * (38.997235-38.840312) + 38.840312),
#     :longitude => (rand * (77.1230767-76.9091637)-77.1230767)
#   )
# end
puts "Making 10 events"
10.times do
  Event.create(
    location:Location.all.sample,
    when:Faker::Time.between(1.days.ago, Time.now, :all),
    title:Faker::Company.bs,
    owner:User.all.sample
  )
end
puts "Making tags"
  Tag.create([{:tag => "bananas"},{:tag => "bonkers"},{:tag => "crazy"},{:tag => "fun"},{:tag => "bad"},{:tag => "awesome"},{:tag => "pretty neat"},{:tag => "hilarios"},{:tag => "drinks"},{:tag => "wasted"},{:tag => "girls"},{:tag => "expensive"},{:tag => "lame"},{:tag => "weird"}])
# 20.times do
#   Tag.create(:tag => Faker::Lorem.word)
# end
puts "Making 3 instances of tagging per user"
# 200.times do
User.all.each do |u|
  3.times do
    Tagging.create(
      :event => Event.all.sample,
      :tag => Tag.all.sample,
      :user => u
    )
  end
end
puts "Making 3 attendances per user"
User.all.each do |u|
  10.times do
    Attendance.create(
      :user => u,
      :event => Event.all.sample
    )
  end
end
puts "Making 100 followings"
100.times do
  follower = User.all.sample
  followed = User.all.sample
  Following.find_or_create_by(followed:followed,follower:follower)
end
puts "making each user vote"
User.all.each do |u|
  5.times do
    Event.all.sample.upvote_by u
  end
  3.times do
    Event.all.sample.downvote_by u
  end
end
