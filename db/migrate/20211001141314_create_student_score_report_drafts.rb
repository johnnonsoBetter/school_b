class CreateStudentScoreReportDrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :student_score_report_drafts do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :score, default: 0
      t.boolean :scored, default: false
      t.references :score_report_draft, null: false, foreign_key: true

      t.timestamps
    end
  end
end
