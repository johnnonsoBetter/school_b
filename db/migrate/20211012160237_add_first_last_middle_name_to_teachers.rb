class AddFirstLastMiddleNameToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
    add_column :teachers, :middle_name, :string
  end
end
