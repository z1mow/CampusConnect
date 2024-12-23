class CreateCommunityGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :community_groups do |t|
      t.string :name
      t.integer :creator_id
      t.timestamps
    end
  end
end
