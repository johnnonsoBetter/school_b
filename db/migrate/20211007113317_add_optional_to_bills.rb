class AddOptionalToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :optional, :boolean, :default => 0
  end
end
