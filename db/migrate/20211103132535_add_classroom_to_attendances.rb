class AddClassroomToAttendances < ActiveRecord::Migration[6.0]
  def change
    
    add_reference :attendances, :classroom, null: false, foreign_key: true
  end
end
