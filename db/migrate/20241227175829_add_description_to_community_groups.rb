class AddDescriptionToCommunityGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :community_groups, :description, :text
  end
end
