class CreateScoreReportDrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :score_report_drafts do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :score_type, null: false, foreign_key: true
      t.boolean :published, default: false
      t.integer :max

      t.timestamps
    end
  end
end
