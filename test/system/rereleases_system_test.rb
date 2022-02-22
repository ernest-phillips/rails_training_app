require "application_system_test_case"

class RereleasesSystemTest < ApplicationSystemTestCase
  test "visiting the new page" do
    # As a user,
    # when I visit /movies/1/rereleases/new
    # I see the title and year of the original
    # I see a form
    movie = create(:movie, title: "The Thing", director_name: "John Carpenter", year: "1982")

    visit new_movie_rerelease_path(movie.id)

    assert_text "The Thing"
    assert_text "1982"
    assert_selector ".form"
  end

  test "using the new page" do
    # As a user,
    # when I visit /movies/1/rereleases/new
    # and enter a rerelease year
    # I can create a rerelease
    movie = create(:movie, title: "The Thing", director_name: "John Carpenter", year: "1982")

    visit new_movie_rerelease_path(movie.id)

    fill_in "Rerelease year", with: "2011"

    click_on "Create Rerelease"

    rerelease = Movie.find_by(title: "The Thing", year: "2011")
    assert rerelease
  end
end
