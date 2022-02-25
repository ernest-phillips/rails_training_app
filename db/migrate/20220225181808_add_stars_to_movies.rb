class AddStarsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :stars, :integer
    add_index :movies, :stars
  end
end
