class AddMessageCountToCommunityGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :community_groups, :message_count, :integer
  end
end
