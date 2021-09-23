class Bill < ApplicationRecord
  belongs_to :student
  has_many :payment_histories
  validates :title, presence: true
  validates :total_amount, numericality: {greater_than: 0}
  
end
