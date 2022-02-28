class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
