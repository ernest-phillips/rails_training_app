require "application_system_test_case"

class MoviesSystemTest < ApplicationSystemTestCase
  test "visiting the show" do
    # As a user,
    # when I visit /movies/1
    # I see the title of the movie "Parasite"
    # I also see the name of the director "Bong Joon-ho"
    director = create(:director, name: "Bong Joon-ho")
    movie = create(:movie, title: "Parasite", director: director)

    visit movie_path(movie.id)
    assert_text "Parasite".upcase
    assert_text "#{I18n.t('movies.show.directed_by')} Bong Joon-ho"

    assert_selector 'img.star', count: movie.stars
  end

  test "visiting the show for a different movie" do
    # As a user,
    # When I visit a movie with the id of 2,
    # I see the title for that movie
    movie = create(:movie, title: "Other Movie")

    visit movie_path(movie.id)
    assert_text "OTHER MOVIE"
  end

  test "visiting the index page" do
    director1 = create(:director, name: "Bong Joon-ho")
    director2 = create(:director, name: "James Cameron")
    movie1 = create(:movie, title: "Parasite", director: director1)
    movie2 = create(:movie, title: "Titanic", director: director2)

    visit "/movies"

    assert_text "Parasite"
    assert_text "Bong Joon-ho"
    assert_text "Titanic"
    assert_text "James Cameron"
  end

  test "new button on index page" do
    visit movies_path

    assert_button "Add New Movie"

    click_on "Add New Movie"

    assert_current_path new_movie_path

    assert_selector ".form"
  end

  test "creating a new movie" do
    director = create(:director, name: "Nobody in Particular")

    visit new_movie_path

    fill_in "Title", with: "A New Movie"

    select "Nobody in Particular", from: "Director"

    click_on "Create"

    assert_text "A NEW MOVIE"

    movie = Movie.order(id: :desc).first
    assert_equal "A New Movie", movie.title
  end

  test "editing a new movie" do
    movie = create(:movie, title: "A Movie To Edit")

    visit movie_path(movie.id)

    click_on "Edit Movie"

    assert_selector ".form"

    fill_in "Title", with: "Edited Movie"

    click_on "Update"

    assert_text "EDITED MOVIE"
  end

  test "deleting a movie" do
    movie = create(:movie)

    visit movie_path(movie.id)

    click_on "Delete Movie"

    accept_confirm

    assert_current_path movies_path

    refute Movie.exists?(movie.id)
  end

  test "members can log in and be greeted by name" do
    member = create(:member, password: "password", password_confirmation: "password")

    visit movies_path

    click_link "Log In"

    fill_in :email, with: member.email
    fill_in :password, with: "password"

    click_button "Submit"

    assert_text member.email
  end

  test "non-members can't log in" do
    visit movies_path

    click_link "Log In"

    fill_in :email, with: "nobody@example.com"
    fill_in :password, with: "password"

    click_button "Submit"

    assert_text "Unknown user or wrong password"
  end
end
