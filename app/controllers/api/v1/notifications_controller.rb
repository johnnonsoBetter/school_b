class Api::V1::NotificationsController < ApplicationController


  def create




     notification = WebPushNotification.new 
     notification.endpoint = params[:endpoint]
     # notification.auth_key = params[:keys][:auth]
     # notification.p256dh_key = params[:keys][:p256dh]

    # # t.string "endpoint"
    # # t.string "auth_key"
    # # t.string "p256dh_key"
    # # t.datetime "created_at", precision: 6, null: false
    # # t.datetime "updated_at", precision: 6, null: false

       puts  params[:keys]


    if notification.save 
      render json: notification, status: :created 
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end


  end
end
