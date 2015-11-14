# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(email:"test@email.com",password:"password",gender:"m",preference:"f",username:"test_guy")
u2 = User.create(email:"test2@email.com",password:"password",gender:"f",preference:"m",username:"test_gal")
