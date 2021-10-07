class AddTotalDebtToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :total_debt, :integer , default: 0
  end
end
