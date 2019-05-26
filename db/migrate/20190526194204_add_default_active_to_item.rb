class AddDefaultActiveToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :active, :boolean, default: true
  end
end
