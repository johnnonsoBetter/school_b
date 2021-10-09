class ExpenseReport < ApplicationRecord
  belongs_to :school
  belongs_to :admin
  validates :title, :amount, presence: true
  validates :amount, numericality: {greater_than: 0}
end
