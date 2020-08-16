class ChangePostcodeToBeStringInStudents < ActiveRecord::Migration[5.2]
  def up
    change_column :clubs, :postcode, :string
  end

  def down
    change_column :clubs, :postcode, :string
  end
end
