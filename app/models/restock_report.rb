class RestockReport < ApplicationRecord
  belongs_to :item
  belongs_to :school
  validates :quantity, presence: true, numericality: {greater_than: 0}
end
