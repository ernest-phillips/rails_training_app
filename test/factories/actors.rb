FactoryBot.define do
  factory :actor do
    name { Faker::Name.name }
    age { rand(100) }
    oscar_nominee { false }
    actors { Array.new(3) { association(:movie, actor: instance) } }
  end
end
