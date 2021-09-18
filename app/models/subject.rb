class Subject < ApplicationRecord

    belongs_to :teacher
    belongs_to :classroom

    validates :name, presence: true
    
end
