class AddColumnBehaviourTypeToBehaviourReports < ActiveRecord::Migration[6.0]
  def change
    add_column :behaviour_reports, :behaviour_type, :string
  end
end
