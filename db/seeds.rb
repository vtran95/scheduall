# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Event.destroy_all
Attendee.destroy_all

@users = User.create([
    {name: "Juan Republic", email: "juan@email.com", interests: "One Republic", password: "juan"},
    {name: "Phillip Phillips", email: "phillip@email.com", interests: "Futurama", password: "phillip"},
    {name: "Spongebob Squarepants", email: "spongebob@email.com", interests: "Jellyfishing", password: "spongebob"},
    {name: "Ash Ketchum", email: "ash@email.com", interests: "Being the very best", password: "ash"},
    {name: "Kanye West", email: "kanye@email.com", interests: "Me", password: "kanye"}
])

@events = Event.create([
    {title: "Archery Tag", description: "If you can dodge a dodgeball, you can dodge a high-velocity arrow", start_date: DateTime.new(2017,8,5,20,00,00), end_date: DateTime.new(2017,8,5,21,30,00), user: User.find_by(name: "Spongebob Squarepants")},
    {title: "Sushi Town", description: "Sushi is love, sushi is life", start_date: DateTime.new(2017,8,12,18,30,00), end_date: DateTime.new(2017,8,12,19,30,00), user: User.find_by(name: "Spongebob Squarepants")},
    {title: "Jellyfishing", description: "Jellyfishing jellyfishing jellyfishing", start_date: DateTime.new(2017,8,15,18,30,00), end_date: DateTime.new(2017,8,15,19,30,00), user: User.find_by(name: "Spongebob Squarepants")}
])

@events.each do |event|
    event.attending_users = User.where.not(name: "Spongebob Squarepants")
end

# @events.each do |event|
#     if event.errors.any?
#         for message in event.errors.full_messages
#             puts message
#         end
#     end
# end