# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


TermDate.create name: "1st Term 2021/2022", start_date: Date.new(2021, 9, 14), end_date: Date.new(2022, 1, 5)
TermDate.create name: "2st Term 2022/2023", start_date: Date.new(2022, 1, 10), end_date: Date.new(2022, 4, 5)