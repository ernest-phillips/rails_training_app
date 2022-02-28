class AddAdminToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :admin, :boolean
  end
end
