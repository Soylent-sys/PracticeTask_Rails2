class RenameChargeColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :charge, :price
  end
end
