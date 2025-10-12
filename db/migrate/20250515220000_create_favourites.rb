class CreateFavourites < ActiveRecord::Migration[8.0]
  def change
    create_table :favourites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favourites, [ :user_id, :exhibition_id ], unique: true
  end
end
