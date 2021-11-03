class Classroom < ApplicationRecord
  belongs_to :school
  has_many :subjects
  has_many :teachers, through: :subjects
  has_many :students
  has_many :attendances
  validates :name, presence: true
  
end
