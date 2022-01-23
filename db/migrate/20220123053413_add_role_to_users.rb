class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, 'admin'
    add_column :users, :role, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :role
    add_column :users, :admin, :boolean
  end
end
