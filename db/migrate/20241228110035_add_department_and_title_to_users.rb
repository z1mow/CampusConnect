class AddDepartmentAndTitleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :department, :string
    add_column :users, :title, :string
  end
end
