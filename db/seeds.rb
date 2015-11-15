# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(email:"test@email.com",password:"password",gender:"m",preference:"f",username:"test_guy")
u2 = User.create(email:"test2@email.com",password:"password",gender:"f",preference:"m",username:"test_gal")

l = Location.create(address:"123 ABC Street", name:"my house")
l2 = Location.create(address:"somewhere else",name:"dark ass alley")
e = Event.create(title:"my birthday", when:"9:30pm",location:l)
e2 = Event.create(title:"doin stuff", when:"3:00am",location:l2)

t1 = Tag.create(tag:"Banger")
t2 = Tag.create(tag:"Terrifying")
t3 = Tag.create(tag:"Burgers")

Tagging.create(event:e,tag:t1)
Tagging.create(event:e,tag:t3)
Tagging.create(event:e2,tag:t2)
Tagging.create(event:e2,tag:t3)

Attendance.create(user:u1,event:e)
Attendance.create(user:u2,event:e)
Attendance.create(user:u1,event:e2)
