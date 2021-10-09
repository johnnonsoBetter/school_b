class FixDefaultForTotalInItemSolds < ActiveRecord::Migration[6.0]
  def change
    change_column :item_solds, :total, :integer, default: 1
    
  end
end
