class RemoveImageFromStudent < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :image
  end
end
