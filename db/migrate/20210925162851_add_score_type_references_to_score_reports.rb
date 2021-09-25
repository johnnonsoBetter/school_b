class AddScoreTypeReferencesToScoreReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :score_reports, :score_type, null: false, foreign_key: true
  end
end
