class CreateItemSolds < ActiveRecord::Migration[6.0]
  def change
    create_table :item_solds do |t|
      t.references :sale_report, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.integer :total

      t.timestamps
    end
  end
end
