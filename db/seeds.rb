# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
Attendee.destroy_all

@events = Event.create([
    {title: "Archery Tag", description: "If you can dodge a dodgeball, you can dodge a high-velocity arrow", start_date: DateTime.new(2017,8,5,20,00,00), end_date: DateTime.new(2017,8,5,21,30,00), user:User.first},
    {title: "Sushi Town", description: "Sushi is love, sushi is life", start_date: DateTime.new(2017,8,12,18,30,00), end_date: DateTime.new(2017,8,12,19,30,00),user:User.first}
])

# @events.each do |event|
#     if event.errors.any?
#         for message in event.errors.full_messages
#             puts message
#         end
#     end
# end