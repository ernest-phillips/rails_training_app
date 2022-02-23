require 'test_helper'

class RereleaseTest < ActiveSupport::TestCase
  test "rerelease does not alter the original movie year" do
    movie = create(:movie, year: "1992")
    rerelease = Rerelease.new(movie, year: "2019")

    rerelease.save

    first_release = Movie.find(movie.id)
    assert_equal "1992", movie.year
  end

  test "rerelease creates a copy of the movie with the specified year" do
    movie = create(:movie, year: "1992")
    rerelease = Rerelease.new(movie, year: "2019")

    assert_difference(-> { Movie.where(title: movie.title).count }, 1) do
      assert rerelease.save
    end

    db_rerelease = Movie.find_by(title: movie.title, year: 2019)
    assert_equal "2019", db_rerelease.year
  end
end
