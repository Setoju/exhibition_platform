class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :exhibition, null: false, foreign_key: true
      t.references :ticket_type, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
