class CreateCastings < ActiveRecord::Migration[7.0]
  def change
    create_table :castings do |t|
      t.references :movie
      t.references :actor

      t.timestamps
    end
  end
end
