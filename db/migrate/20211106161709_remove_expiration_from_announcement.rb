class RemoveExpirationFromAnnouncement < ActiveRecord::Migration[6.0]
  def change
    remove_column :announcements, :expiration
  end
end
