class ChangeAmountOfDebtRecoveredReports < ActiveRecord::Migration[6.0]
  def change
    remove_column :debt_recovered_reports, :amount
    
  end
end
