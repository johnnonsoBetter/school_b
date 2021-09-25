class CreateBehaviourReports < ActiveRecord::Migration[6.0]
  def change
    create_table :behaviour_reports do |t|
      t.string :title
      t.string :description
      t.string :type
      t.references :student, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
