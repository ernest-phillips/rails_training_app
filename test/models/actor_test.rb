require "test_helper"

class ActorTest < ActiveSupport::TestCase
  test "actor is in many movies" do
    actor = create(:actor, :with_movies)

    assert_equal 3, actor.movies.count
  end


  test "actor can be hired" do
    actor = Actor.new(name: "Kang-ho Song")
    assert_equal actor.hire, "Kang-ho Song is now working for your studio."
  end
end
