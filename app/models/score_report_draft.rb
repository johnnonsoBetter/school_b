class ScoreReportDraft < ApplicationRecord
  belongs_to :subject
  belongs_to :score_type
  belongs_to :teacher
  has_many :student_score_report_drafts
end