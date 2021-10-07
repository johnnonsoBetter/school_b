class RemoveUnneccessaryColumnFromBills < ActiveRecord::Migration[6.0]
  def change
    remove_column :bills, :total_amount
    remove_column :bills, :description 
    remove_column :bills, :title
  end
end
