class CreateArtistExhibits < ActiveRecord::Migration[8.0]
  def change
    create_table :artist_exhibits do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :exhibit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
