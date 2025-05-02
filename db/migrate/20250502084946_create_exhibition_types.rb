class CreateExhibitionTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :exhibition_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
