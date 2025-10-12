class AddUniqueIndexToArtistExhibits < ActiveRecord::Migration[8.0]
  def change
    add_index :artist_exhibits, [ :artist_id, :exhibit_id ], unique: true
  end
end
