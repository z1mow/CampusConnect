class AddDefaultToCommunityGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :community_groups, :default, :boolean
  end
end
