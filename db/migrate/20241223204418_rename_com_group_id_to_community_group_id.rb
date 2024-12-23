class RenameComGroupIdToCommunityGroupId < ActiveRecord::Migration[7.2]
  def change
    rename_column :group_members, :com_group_id, :community_group_id
  end
end
