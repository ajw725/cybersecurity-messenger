# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :subject_ciphertext
      t.text :body_ciphertext

      t.references :sender, index: true, foreign_key: { to_table: :users, on_delete: :nullify }
      t.references :recipient, index: true, foreign_key: { to_table: :users, on_delete: :nullify }

      t.timestamps
    end
  end
end
