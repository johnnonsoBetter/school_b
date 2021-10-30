class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_api_v1_guidance!, :find_web_push_notification, only: [:create]

  def create


    

     notification = WebPushNotification.new 
     notification.endpoint = params[:subscription][:endpoint]
     notification.auth_key = params[:subscription][:keys][:auth]
     notification.p256dh_key = params[:subscription][:keys][:p256dh]
     notification.guidance = current_api_v1_guidance

    if notification.save 
      render json: notification, status: :created 
    else
      render json: notification.errors.messages, status: :unprocessable_entity
    end


  end

  def find_web_push_notification 
    
      web_push = current_api_v1_guidance.web_push_notifications.find_by_auth_key(params[:subscription][:keys][:auth])

      

      unless web_push.nil?
        render json: "", status: :no_content 
      end
  end


end
