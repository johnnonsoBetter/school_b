module WebPushNotificationSenderHelper
    


    def send_push_notification_to_guidances(message, guidances) 

      guidances.each do |guidance| 


        


        guidance.web_push_notifications.each do |web_push|
            

            begin
                send_push_notification(message, web_push)
            rescue StandardError => ex      
               web_push.destroy
            end

        end

      end
    end


    def send_push_notification_to_guidance(message, guidance) 

      guidance.web_push_notifications.each do |web_push|
            send_push_notification(message, web_push)

        end
    end



    private


    def send_push_notification(message, webpush)

      Webpush.payload_send(
        message: JSON.generate(message),
        endpoint: webpush.endpoint,
        p256dh: webpush.p256dh_key,
        auth: webpush.auth_key,
        vapid: {
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        },
    
      )


  end
end
