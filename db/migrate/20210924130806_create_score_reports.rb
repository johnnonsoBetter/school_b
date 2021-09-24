class CreateScoreReports < ActiveRecord::Migration[6.0]
  def change
    create_table :score_reports do |t|
      t.integer :max
      t.integer :score
      t.string :remark
      t.references :teacher, null: false, foreign_key: true
      t.references :term_activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
