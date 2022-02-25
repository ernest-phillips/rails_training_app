require "test_helper"

class ActorTest < ActiveSupport::TestCase
  test "actor is in many movies" do
    actor = create(:actor)
    actor.movie.push(create(:movie)) 

    assert_equal 3, actor.movies.count
  end
end
