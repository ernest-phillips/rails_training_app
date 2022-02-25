require "test_helper"

class ActorTest < ActiveSupport::TestCase
  test "actor is in many movies" do
    actor = create(:actor)
    actor.movie.push(create(:movie)) 

    assert_equal 1, actor.movies.count
  end
end
