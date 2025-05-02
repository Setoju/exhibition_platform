class CreateExhibits < ActiveRecord::Migration[8.0]
  def change
    create_table :exhibits do |t|
      t.string :name
      t.string :description
      t.float :width
      t.float :height
      t.float :depth
      t.float :weight
      t.references :exhibition_type, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true
      t.datetime :creation_date
      t.string :material
      t.boolean :copy

      t.timestamps
    end
  end
end
