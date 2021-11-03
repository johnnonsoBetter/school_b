class AddIsPresentToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :is_present, :boolean, default: true
  end
end
