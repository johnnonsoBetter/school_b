class AddReferenceSchoolToAdmin < ActiveRecord::Migration[6.0]
  def change
    add_reference :admins, :school, null: false, foreign_key: true
  end
end
