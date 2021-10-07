class Bill < ApplicationRecord
  belongs_to :student
  belongs_to :bill_report
  has_many :payment_histories
 
end
