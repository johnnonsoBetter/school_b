class StudentScoreReportDraft < ApplicationRecord
  belongs_to :student
  belongs_to :score_report_draft
  validates :score, numericality: { only_integer: true }
end
