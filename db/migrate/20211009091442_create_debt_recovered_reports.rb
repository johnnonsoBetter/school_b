class CreateDebtRecoveredReports < ActiveRecord::Migration[6.0]
  def change
    create_table :debt_recovered_reports do |t|
      t.string :amount
      t.references :school, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.references :bill, null: false, foreign_key: true
      t.timestamps
    end
  end
end
