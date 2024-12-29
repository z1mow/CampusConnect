class AddStudentClassToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :student_class, :string
  end
end
