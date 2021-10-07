class AddBillReportToBills < ActiveRecord::Migration[6.0]
  def change
    add_reference :bills, :bill_report, null: true, foreign_key: true
  end
end
