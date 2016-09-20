class AddPictureToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :picture, :string
  end
end
