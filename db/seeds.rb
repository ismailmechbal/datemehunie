# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


breed_categories = BreedCategory.create([{ name: 'Cat' }, { name: 'Dog' }])

BreedItem.create(
  [
    { name: 'Chihuahua', breed_category: breed_categories.last },
    { name: 'Pitbull', breed_category: breed_categories.last },
    { name: 'Siamois', breed_category: breed_categories.first }
  ]
)

50.times do |i|
  User.create!(
    email: Faker::Internet.email,
    password: "aqwzsxedc",
    password_confirmation: "aqwzsxedc"
  )
end

gender = ["male", "female"]

50.times do |i|
  Profile.create!(
    user_id: i+1,
    breed_item_id: rand(1..3),
    name: Faker::Name.name,
    gender: gender[rand(0..1)],
    dob: Faker::Date.backward(14),
    body: Faker::Hipster.paragraph(2)
  )
end