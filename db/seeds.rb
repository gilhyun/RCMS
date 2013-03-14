# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user=User.create(userid:"test", email:"railsdev71@gmail.com",password:"test")
category=Category.create(name:"RCMS_CATEGORY1",description:"RCMS BASE CATEGORY1")
category2=Category.create(name:"RCMS_CATEGORY2",description:"RCMS BASE CATEGORY2")

user.save!
category.save!
category2.save!

