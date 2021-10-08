class CreateRestockReports < ActiveRecord::Migration[6.0]
  def change
    create_table :restock_reports do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
