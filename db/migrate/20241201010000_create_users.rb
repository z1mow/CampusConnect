class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile_picture
      t.string :department     
      t.string :title         
      t.string :student_class 
      t.timestamps
    end
    add_index :users, :name
  end
end

