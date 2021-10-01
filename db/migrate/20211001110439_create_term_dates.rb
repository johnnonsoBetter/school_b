class CreateTermDates < ActiveRecord::Migration[6.0]
  def change
    create_table :term_dates do |t|
      t.date :start_date
      t.date :end_date
      t.string :name

      t.timestamps
    end
  end
end
