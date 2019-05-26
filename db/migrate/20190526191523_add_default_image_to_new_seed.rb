class AddDefaultImageToNewSeed < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :image, :string, default: "https://bit.ly/2HWf7qo"
  end
end
