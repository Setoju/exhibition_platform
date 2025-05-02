class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :biography
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
