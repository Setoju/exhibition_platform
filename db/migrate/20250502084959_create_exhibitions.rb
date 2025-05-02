class CreateExhibitions < ActiveRecord::Migration[8.0]
  def change
    create_table :exhibitions do |t|
      t.string :name
      t.string :description
      t.references :exhibition_center, null: false, foreign_key: true
      t.references :exhibition_type, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
