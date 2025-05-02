class CreateExhibitionCenters < ActiveRecord::Migration[8.0]
  def change
    create_table :exhibition_centers do |t|
      t.string :name
      t.string :address
      t.string :opening_hours
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
