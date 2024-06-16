FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location#{n}" }
    address { "Jordan-Amman" }
  end
end