class RemoveSellingPriceFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :selling_price
  end
end
