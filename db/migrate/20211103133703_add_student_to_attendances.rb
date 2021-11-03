class AddStudentToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_reference :attendances, :student, null: false, foreign_key: true
  end
end
