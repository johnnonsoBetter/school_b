class AddPaidAndBalanceToBills < ActiveRecord::Migration[6.0]
  def change

    add_column :bills, :paid, :integer, :default => 0
    add_column :bills, :balance, :integer, :default => 0
  end
end
