class ChangeColumnTypeStartDateAndEndDateOfTermDates < ActiveRecord::Migration[6.0]
  def change
    change_column :term_dates, :start_date, :string
    change_column :term_dates, :end_date, :string
   
  end

  
end
