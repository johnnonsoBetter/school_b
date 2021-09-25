class RemoveUnnecessaryAttributesFromStudents < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :name
    remove_column :students, :nickname
  end
end
