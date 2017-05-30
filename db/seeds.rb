# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Seed Users
user = {}
user['password'] = 'asdf'
gender = ['male','female']
# user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['gender'] = gender.sample
    user['age'] = (Date.today - Faker::Date.between(50.years.ago, Date.today)) / 365
    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['name'] = Faker::App.name
    # listing['place_type'] = rand(1..3)
    # listing['property_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample

    # listing['room_number'] = rand(0..5)
    listing['num_of_bedrooms'] = rand(1..6)
    listing['num_of_guests'] = rand(1..10)

    # listing['country'] = Faker::Address.country
    # listing['state'] = Faker::Address.state
    # listing['city'] = Faker::Address.city
    # listing['zipcode'] = Faker::Address.zip_code
    listing['address'] = Faker::Address.street_address

    # listing['price'] = rand(80..500)
    listing['description'] = Faker::Hipster.sentence

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end