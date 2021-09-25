class RemoveColumnTypeFromBehaviourReports < ActiveRecord::Migration[6.0]
  def change
    remove_column :behaviour_reports, :type, :string
  end
end
