class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :title
      t.string :description
      t.integer :total_amount
      t.boolean :payment_completed
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
