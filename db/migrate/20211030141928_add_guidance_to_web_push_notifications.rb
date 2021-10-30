class AddGuidanceToWebPushNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :web_push_notifications, :guidance, null: false, foreign_key: true
  end
end
