class CreateExpenseReports < ActiveRecord::Migration[6.0]
  def change
    create_table :expense_reports do |t|
      t.integer :amount
      t.string :title
      t.references :school, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
