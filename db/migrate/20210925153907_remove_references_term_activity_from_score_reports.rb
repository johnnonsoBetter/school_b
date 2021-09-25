class RemoveReferencesTermActivityFromScoreReports < ActiveRecord::Migration[6.0]
  def change
    remove_reference :score_reports, :term_activity, null: false, foreign_key: true
  end
end
