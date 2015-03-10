# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

me = User.create!(email: "dave@reliacode.com", password: "Pass13!#", approved: true)
Product.create!(id: 46, name: "apples", stock: 100)
Product.create!(id: 70, name: "oranges", stock: 100)
