class RemovePhotosFromTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :photos
    drop_table :products
  end
end
