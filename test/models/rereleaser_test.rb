require 'test_helper'

class RereleaserTest < ActiveSupport::TestCase
  test "rerelease does not alter the original movie year" do
    movie = create(:movie, year: "1992")
    rereleaser = Rereleaser.new(movie)

    rereleaser.run(year: "2019")

    first_release = Movie.find(movie.id)
    assert_equal "1992", movie.year
  end

  test "rerelease creates a copy of the movie with the specified year" do
    movie = create(:movie, year: "1992")
    rereleaser = Rereleaser.new(movie)

    assert_difference(-> { Movie.where(title: movie.title).count }, 1) do
      rereleaser.run(year: "2019")
    end

    rerelease = Movie.find_by(title: movie.title, year: 2019)
    assert_equal "2019", rerelease.year
  end
end
