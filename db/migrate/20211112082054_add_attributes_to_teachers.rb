class AddAttributesToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :date_of_birth, :date 
    add_column :teachers, :address, :string
    add_column :teachers, :state, :string 
    add_column :teachers, :lga, :string  
    add_column :teachers, :religion, :string
    add_column :teachers, :phone, :string
  end
end
