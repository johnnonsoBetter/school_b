class Subject < ApplicationRecord
    before_create :set_name

    belongs_to :teacher
    belongs_to :classroom

    validates :name, presence: true

    private 
    def set_name 

        
        pre_name = self.name
        self.name = "#{self.classroom.name} #{pre_name}"

    end
    
end
