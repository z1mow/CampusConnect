class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :group, null: false, foreign_key: true
      t.text :content, null: false
      t.datetime :sent_at, null: false
      
      t.timestamps
    end
    
    add_index :messages, :sent_at
  end
end 