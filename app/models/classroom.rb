class Classroom < ApplicationRecord
  belongs_to :school
  has_many :subjects
  has_many :teachers, through: :subjects
  validates :name, presence: true
end
