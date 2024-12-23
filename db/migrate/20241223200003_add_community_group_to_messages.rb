class AddCommunityGroupToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :community_group, null: false, foreign_key: true
  end
end
