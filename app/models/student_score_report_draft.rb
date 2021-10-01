class StudentScoreReportDraft < ApplicationRecord
  belongs_to :student
  belongs_to :score_report_draft
end
