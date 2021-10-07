class BillReport < ApplicationRecord
  belongs_to :school
  belongs_to :admin
  has_many :bills

  validates :amount, numericality: {greater_than: 0}
  
  
end
