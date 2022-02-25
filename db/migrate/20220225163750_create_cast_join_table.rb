class CreateCastJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :actors, :movies do |t|
      t.index [:actor_id, :movie_id], unique: true
      t.index [:movie_id, :actor_id], unique: true
    end
  end
end
