class Api::V1::NotificationsController < ApplicationController
  def create

    notification = WebPushNotification.new (

        endpoint: params[:endpoint],
        auth_key: params[:auth_key],
        p256dh_key: params[:keys][:p256dh],

      )


    if notification.save 
      render json: notification, status: :created 
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end
  end
end
