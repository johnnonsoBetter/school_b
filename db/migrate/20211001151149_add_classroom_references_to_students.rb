class AddClassroomReferencesToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :classroom, null: true, foreign_key: true
    
  end
end
