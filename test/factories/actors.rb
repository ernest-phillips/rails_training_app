FactoryBot.define do
  factory :actor do
    name { Faker::Name.name }
    age { rand(100) }
    oscar_nominee { false }
  end
end
