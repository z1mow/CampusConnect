class CreateGroupMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :group_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community_group, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
