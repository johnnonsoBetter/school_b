class SaleReport < ApplicationRecord
  belongs_to :school
  belongs_to :admin
  validates :total, presence: true
  validates :total, numericality: {greater_than: 0}
end
