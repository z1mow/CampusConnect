class AddNameToChatrooms < ActiveRecord::Migration[7.2]
  def change
    add_column :chatrooms, :name, :string
  end
end
