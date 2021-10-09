class CreateSaleReports < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_reports do |t|
      t.integer :total
      t.references :school, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.[] :items_sold

      t.timestamps
    end
  end
end
