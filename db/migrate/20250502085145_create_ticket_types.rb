class CreateTicketTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_types do |t|
      t.string :type_name
      t.string :description
      t.float :discount
      t.string :access_level

      t.timestamps
    end
  end
end
