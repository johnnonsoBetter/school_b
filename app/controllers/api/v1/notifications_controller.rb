class Api::V1::NotificationsController < ApplicationController


  def create




     notification = WebPushNotification.new 
     notification.endpoint = params[:endpoint]
    # t.string "endpoint"
    # t.string "auth_key"
    # t.string "p256dh_key"
    # t.datetime "created_at", precision: 6, null: false
    # t.datetime "updated_at", precision: 6, null: false

      puts  "this is the notification", notification


    if notification.save 
      render json: notification, status: :created 
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end


  end
end
