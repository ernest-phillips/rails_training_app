require 'test_helper'

class RereleaseTest < ActiveSupport::TestCase
  test "rerelease does not alter the original movie year" do
    movie = create(:movie, year: "1992")
    rerelease = Rerelease.new(movie, year: "2019")

    rerelease.save

    first_release = Movie.find(movie.id)
    assert_equal "1992", first_release.year
  end

  test "rerelease creates a copy of the movie with the specified year" do
    movie = create(:movie, year: "1992")
    rerelease = Rerelease.new(movie, year: "2019")

    assert_difference(-> { Movie.where(title: movie.title).count }, 1) do
      rerelease.save
    end

    rerelease_movie = Movie.find(rerelease.id)
    assert_equal "2019", rerelease_movie.year
  end
end
