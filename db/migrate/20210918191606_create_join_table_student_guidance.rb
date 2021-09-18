class CreateJoinTableStudentGuidance < ActiveRecord::Migration[6.0]
  def change
    create_join_table :students, :guidances do |t|
      t.index [:student_id, :guidance_id]
      t.index [:guidance_id, :student_id]
    end
  end
end
