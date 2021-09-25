class ScoreReport < ApplicationRecord
  belongs_to :teacher
  belongs_to :student
  belongs_to :subject
  belongs_to :score_type
end
