require "test_helper"

class ActorTest < ActiveSupport::TestCase
  test "actor is in many movies" do
    actor = create(:actor, :with_movies)

    assert_equal 3, actor.movies.count
  end
end
