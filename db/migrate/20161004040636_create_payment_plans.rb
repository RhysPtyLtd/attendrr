class CreatePaymentPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_plans do |t|
      t.references :club, foreign_key: true
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.string :frequency
      t.boolean :active, default: true
      t.integer :classes_amount

      t.timestamps
    end
  end
end
