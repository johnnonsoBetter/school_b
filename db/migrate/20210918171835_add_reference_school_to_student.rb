class AddReferenceSchoolToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :school, null: false, foreign_key: true
  end
end
