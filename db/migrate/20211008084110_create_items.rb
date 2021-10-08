class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :selling_price
      t.integer :cost_price
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
