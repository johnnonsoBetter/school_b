class RemoveCostPriceFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :cost_price
  end
end
