FactoryBot.define do
  factory :power_bank do
    name { "power_bank1" }
    association :station
    association :warehouse
    association :user
  end
end