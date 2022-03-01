require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
  test "director has a name and age" do
    director = create(:director, name: "Bong Joon-ho", age: 50)

    assert_equal director.name, "Bong Joon-ho"
    assert_equal director.age, 50
  end

  test "director can be hired" do
    director = Director.new(name: "Bong Joon-ho")
    assert_equal director.hire, "Bong Joon-ho is now working for your studio."
  end
end
