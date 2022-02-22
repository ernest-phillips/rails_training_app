require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test "movie is valid with a title" do
    director = build(:director, name: "Bong Joon-ho")
    movie = build(:movie, title: "Parasite", director: director)
    assert_equal movie.title, "Parasite"
    assert_equal movie.director.name, "Bong Joon-ho"
  end

  test "movie is not valid without a title" do
    movie = build(:movie, title: " ")
    refute movie.valid?
  end

  test "passing an existing director_name will attach a director" do
    existing_director = create(:director)
    movie = build(:movie, director_name: existing_director.name)

    assert movie.valid?
    assert_equal existing_director.id, movie.director.id
  end

  test "passing a new director name will attach a new director" do
    movie = build(:movie, director_name: "Ed Wood")

    assert movie.valid?
    refute movie.director.persisted?
    assert_equal "Ed Wood", movie.director.name
  end

  # Make a method that returns an array of just movie titles.
  #
  test "lists movie titles" do
    create(:movie, title: "Movie 1")
    create(:movie, title: "Movie 2")

    titles = Movie.titles

    assert_equal ["Movie 1", "Movie 2"], titles
  end

  # Make a method that returns all movies in order of most to least Facebook likes.
  test "lists movies in order of facebook likes" do
    movie1 = create(:movie, title: "Movie 1", facebook_likes: 100)
    movie2 = create(:movie, title: "Movie 2", facebook_likes: 2)

    movies = Movie.sorted_by_facebook_likes

    assert_equal [movie1, movie2], movies
  end

  # Make a method that can find a movie by its title, and tell you what year it was released.
  test "find a movies by title and return the year" do
    create(:movie, title: "Movie 1", year: "2022")
    create(:movie, title: "Movie 2", year: "1982")

    year = Movie.release_year_by_title("Movie 1")

    assert_equal "2022", year
  end

  # Make a method that returns the number of movies in the database with more than a given number of Facebook likes
  test "counts movies with more facebook likes" do
    create(:movie, title: "Movie 1", facebook_likes: 100)
    create(:movie, title: "Movie 2", facebook_likes: 2)

    count = Movie.count_with_facebook_likes(10)

    assert_equal 1, count
  end

  test "rerelease does not alter the original movie year" do
    movie = create(:movie, year: "1992")

    movie.rerelease(year: "2019")

    first_release = Movie.find(movie.id)
    assert_equal "1992", movie.year
  end

  test "rerelease creates a copy of the movie with the specified year" do
    movie = create(:movie, year: "1992")

    assert_difference(-> { Movie.where(title: movie.title).count }, 1) do
      movie.rerelease(year: "2019")
    end

    rerelease = Movie.find_by(title: movie.title, year: 2019)
    assert_equal "2019", rerelease.year
  end
end
