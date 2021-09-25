class AddFullNameToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :full_name, :string
  end
end
