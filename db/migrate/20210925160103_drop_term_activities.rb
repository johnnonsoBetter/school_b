class DropTermActivities < ActiveRecord::Migration[6.0]
  def change
    drop_table :term_activities
  end
end
