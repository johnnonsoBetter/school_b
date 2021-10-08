class Item < ApplicationRecord
  belongs_to :school

  validates  :name, :selling_price, presence: true
  validates :selling_price, numericality: {greater_than: 0}

end
