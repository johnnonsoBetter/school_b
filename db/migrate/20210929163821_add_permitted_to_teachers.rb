class AddPermittedToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :permitted, :boolean, :default => false
   
  end
end
