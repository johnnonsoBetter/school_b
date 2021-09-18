class AddUniquenessToSchool < ActiveRecord::Migration[6.0]
  def change
    add_index :schools, :name, :unique => true
   
  end
end
