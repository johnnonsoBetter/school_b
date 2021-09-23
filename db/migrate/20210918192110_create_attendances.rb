class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.boolean :present
      t.references :term_activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
