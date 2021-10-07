class CreateBillReports < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_reports do |t|
      t.string :title
      t.integer :amount
      t.references :school, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
