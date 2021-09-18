class TermActivity < ApplicationRecord
  belongs_to :student

  validates :term, presence: true
end
