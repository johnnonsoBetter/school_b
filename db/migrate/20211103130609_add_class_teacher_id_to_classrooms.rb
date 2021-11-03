class AddClassTeacherIdToClassrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :classrooms, :class_teacher_id, :integer
   
  end
end
