class RenameContentToBodyInMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :content, :body
  end
end
