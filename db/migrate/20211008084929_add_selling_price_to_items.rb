class AddSellingPriceToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :selling_price, :integer
  
  end
end
