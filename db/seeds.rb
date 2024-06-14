# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create(
  email: "mosaab@email.com",
  password: "password",
  password_confirmation: "password",
  isAdmin: "admin",
)

Location.create(
  name: "Amman",
  address: "Jordan-Amman"
)
Location.create(
  name: "Irbid",
  address: "Jordan-Irbid"
)
Location.create(
  name: "Aqaba",
  address: "Jordan-Aqaba"
)