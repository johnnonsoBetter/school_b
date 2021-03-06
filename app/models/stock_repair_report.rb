class StockRepairReport < ApplicationRecord
  belongs_to :item
  belongs_to :school
  belongs_to :admin
  validates :quantity, presence: true, numericality: {greater_than: -1}
end
