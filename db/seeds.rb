# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin = User.find_or_create_by(email: 'admin@admin.com') do |a|
  a.name =  'Mr. Admin'
  a.password = 'password'
end
admin.admin!
member = User.find_or_create_by(email: 'member@member.com') do |a|
  a.name =  'Happy Member'
  a.password = 'password'
end
member.member!
guest = User.find_or_create_by(email: 'guest@guest.com') do |a|
  a.name =  'A Guest'
  a.password = 'password'
end
guest.guest!
Project.find_or_create_by(name: 'WeWIP')
Project.find_or_create_by(name: 'Brand Redesign')
Project.find_or_create_by(name: 'Project Wayfinder')
