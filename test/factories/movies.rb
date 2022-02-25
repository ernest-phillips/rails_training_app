FactoryBot.define do
  factory :movie do
    title { Faker::Superhero.name }
    director
    facebook_likes { rand(100) }
    plot_keywords { "#{Faker::Lorem.word}|#{Faker::Lorem.word}"}
    year { Faker::Date.between(from: 10.years.ago, to: Date.today).year }
    stars { rand(5) }
  end
end
