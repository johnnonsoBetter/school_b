class TermActivity < ApplicationRecord
  belongs_to :student

  validates :term, presence: true
  has_many :score_reports

end
