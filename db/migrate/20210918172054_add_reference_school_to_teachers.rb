class AddReferenceSchoolToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_reference :teachers, :school, null: false, foreign_key: true
  end
end
