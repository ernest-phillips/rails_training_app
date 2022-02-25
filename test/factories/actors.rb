FactoryBot.define do
  factory :actor do
    name { Faker::Name.name }
    age { rand(100) }
    oscar_nominee { false }
    
    trait :with_movies do
      movies { Array.new(3) { association(:movie, actors: instance) } }
    end    
  end
end
