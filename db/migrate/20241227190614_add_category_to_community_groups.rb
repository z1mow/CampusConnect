class AddCategoryToCommunityGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :community_groups, :category, :string
  end
end
