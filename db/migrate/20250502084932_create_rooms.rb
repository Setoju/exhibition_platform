class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.references :exhibition_center, null: false, foreign_key: true
      t.string :name
      t.float :width
      t.float :height
      t.float :depth

      t.timestamps
    end
  end
end
