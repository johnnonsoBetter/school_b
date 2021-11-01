class AddAttributesToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :date_of_birth, :date 
    add_column :students, :date_of_admission, :date
    add_column :students, :address, :string
    add_column :students, :state, :string 
    add_column :students, :lga, :string  
    add_column :students, :religion, :string


  end
end
