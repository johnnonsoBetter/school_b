class PaymentHistory < ApplicationRecord
  belongs_to :bill
  validates :amount, numericality: {greater_than: 0}
end
