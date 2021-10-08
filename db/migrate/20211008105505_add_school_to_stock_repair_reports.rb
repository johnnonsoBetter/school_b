class AddSchoolToStockRepairReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :stock_repair_reports, :school, null: false, foreign_key: true
  end
end
