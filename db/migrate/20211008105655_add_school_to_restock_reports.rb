class AddSchoolToRestockReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :restock_reports, :school, null: false, foreign_key: true
  end
end
