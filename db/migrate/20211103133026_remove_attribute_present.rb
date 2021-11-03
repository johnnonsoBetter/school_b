class RemoveAttributePresent < ActiveRecord::Migration[6.0]
  def change
    remove_column :attendances, :present
  end
end
