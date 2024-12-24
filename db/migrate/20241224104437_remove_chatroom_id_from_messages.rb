class RemoveChatroomIdFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :chatroom_id, :integer
  end
end