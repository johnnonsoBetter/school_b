class AddReferenceSubjectToScoreReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :score_reports, :subject, null: false, foreign_key: true
  end
end
