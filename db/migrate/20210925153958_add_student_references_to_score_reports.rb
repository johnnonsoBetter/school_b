class AddStudentReferencesToScoreReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :score_reports, :student, null: false, foreign_key: true
  end
end
