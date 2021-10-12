class AddAmountDebtRecoveredReports < ActiveRecord::Migration[6.0]
  def change
    add_column :debt_recovered_reports, :amount, :integer
   
  end
end
