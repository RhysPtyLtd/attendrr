class AddSizeToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :size, :string
  end
end
