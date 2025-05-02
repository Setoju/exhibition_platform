class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :ticket, null: false, foreign_key: true
      t.datetime :purchase_date
      t.datetime :purchase_time
      t.string :customer_name
      t.string :customer_email

      t.timestamps
    end
  end
end
