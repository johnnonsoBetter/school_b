class AddNoAttendanceToSchool < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :no_attendance, :boolean, default: false
   
  end
end
