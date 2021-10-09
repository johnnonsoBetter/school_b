class AddAdminToRestockReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :restock_reports, :admin, null: false, foreign_key: true
  end
end
