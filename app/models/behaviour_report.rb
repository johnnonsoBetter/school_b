class BehaviourReport < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  validates :title, :description, :behaviour_type, presence: true
end
