require 'test_helper'

class RereleasesTest < ActionDispatch::IntegrationTest
  test "does not alter the original movie year" do
    movie = create(:movie, year: "1992")

    post movie_rereleases_path(movie), params: {
      year: 2019,
    }

    first_release = Movie.find(movie.id)
    assert_equal "1992", movie.year
  end

  test "redirects to movie rerelease show page" do
    movie = create(:movie, year: "1992")

    post movie_rereleases_path(movie), params: {
      year: 2019,
    }

    rerelease = Movie.find_by(title: movie.title, year: 2019)
    assert_redirected_to movie_path(rerelease)
  end

  test "creates a copy of the movie with the specified year" do
    movie = create(:movie, year: "1992")

    assert_difference(-> { Movie.where(title: movie.title).count }, 1) do
      post movie_rereleases_path(movie), params: {
        year: 2019,
      }
    end

    rerelease = Movie.find_by(title: movie.title, year: 2019)
    assert_equal "2019", rerelease.year
  end
end
