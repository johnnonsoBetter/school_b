class AddAdminToStockRepairReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :stock_repair_reports, :admin, null: false, foreign_key: true
  end
end
