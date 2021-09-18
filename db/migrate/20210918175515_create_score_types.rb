class CreateScoreTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :score_types do |t|
      t.string :name
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
