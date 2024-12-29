class CreateDirectMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :direct_messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.text :content, null: false

      t.timestamps
    end

    add_index :direct_messages, [:sender_id, :receiver_id]
  end
end
