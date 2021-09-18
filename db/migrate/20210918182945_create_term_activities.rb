class CreateTermActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :term_activities do |t|
      t.string :term
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
