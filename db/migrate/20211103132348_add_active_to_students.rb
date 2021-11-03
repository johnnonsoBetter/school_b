class AddActiveToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :active, :boolean, default: true
  end
end
