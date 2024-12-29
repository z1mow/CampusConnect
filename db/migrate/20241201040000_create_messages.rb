class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.references :community_group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
