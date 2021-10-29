class Api::V1::NotificationsController < ApplicationController


  def create




     notification = WebPushNotification.new 
     notification.endpoint = subscription[:endpoint]
     notification.auth_key = subscription[:keys][:auth]
     notification.p256dh_key = subscription[:keys][:p256dh]

    # # t.string "endpoint"
    # # t.string "auth_key"
    # # t.string "p256dh_key"
    # # t.datetime "created_at", precision: 6, null: false
    # # t.datetime "updated_at", precision: 6, null: false

        puts subscription


    if notification.save 
      render json: notification, status: :created 
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end


  end

  def subscription 
    params.require(:subscription).permit(:endpoint, :keys)
  end
end
