class RemoveReferencesTermActivityFromAttendances < ActiveRecord::Migration[6.0]
  def change
    remove_reference :attendances, :term_activity, null: false, foreign_key: true
  end
end
