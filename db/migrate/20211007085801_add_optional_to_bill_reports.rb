class AddOptionalToBillReports < ActiveRecord::Migration[6.0]
  def change
    add_column :bill_reports, :optional, :boolean, default: false
  end
end
