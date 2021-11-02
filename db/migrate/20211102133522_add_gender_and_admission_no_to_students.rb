class AddGenderAndAdmissionNoToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :gender, :string 
    add_column :students, :admission_no, :string
  end
end
