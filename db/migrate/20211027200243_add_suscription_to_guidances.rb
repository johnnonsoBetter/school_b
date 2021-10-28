class AddSuscriptionToGuidances < ActiveRecord::Migration[6.0]
  def change
    add_column :guidances, :subscription, :jsonb, default: {}
   
  end
end
