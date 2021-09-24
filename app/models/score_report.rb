class ScoreReport < ApplicationRecord
  belongs_to :teacher
  belongs_to :term_activity
end
