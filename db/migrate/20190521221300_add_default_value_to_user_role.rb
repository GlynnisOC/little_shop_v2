class AddDefaultValueToUserRole < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role, :integer, :default => 0
    change_column :users, :active, :boolean, :default => true
  end
end
