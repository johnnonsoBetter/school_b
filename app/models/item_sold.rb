class ItemSold < ApplicationRecord
  before_create :set_total
  
  belongs_to :sale_report
  belongs_to :item
  validates :quantity, :total, presence: true, numericality: {greater_than: 0}



  private 

  def set_total 
   
    self.total = item.selling_price * quantity
    
  end
end
