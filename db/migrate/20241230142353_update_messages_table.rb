class UpdateMessagesTable < ActiveRecord::Migration[7.2]
  def change
    # user_id'yi references olarak değiştirme
    change_column_null :messages, :user_id, false

    # Foreign key zaten yoksa ekle
    unless foreign_key_exists?(:messages, :users)
      add_foreign_key :messages, :users
    end
   
    # body sütununu null kısıtlaması ekleme
    change_column_null :messages, :body, false
  end
end
