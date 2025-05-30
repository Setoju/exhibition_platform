# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      ## Database authenticatable (skip email as it's already added)
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    add_index :users, :reset_password_token, unique: true
  end
end
