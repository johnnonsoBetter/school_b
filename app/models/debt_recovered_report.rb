class DebtRecoveredReport < ApplicationRecord
  belongs_to :school
  belongs_to :admin
  belongs_to :bill


  validates :amount, presence: true
  validates :amount, numericality: {greater_than: 0}
  
end
