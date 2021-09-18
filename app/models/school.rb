class School < ApplicationRecord
    validates :name, presence: true
    has_many :admins
    has_many :students 
    has_many :teachers
    has_many :classrooms
    
end
