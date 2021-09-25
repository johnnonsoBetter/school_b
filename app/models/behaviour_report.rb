class BehaviourReport < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  validates :title, :description, :type, presence: true
end
