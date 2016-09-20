class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.references :club, foreign_key: true
      t.string :email
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.integer :postcode
      t.string :phone1
      t.string :phone2
      t.string :first_name
      t.string :last_name
      t.string :parent1_first_name
      t.string :parent1_last_name
      t.string :parent2_first_name
      t.string :parent2_last_name
      t.date :dob

      t.timestamps
    end
  end
end
