class Subject < ApplicationRecord

    belongs_to :teacher
    belongs_to :classroom
end
