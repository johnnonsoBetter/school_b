module WebPushNotificationSenderHelper
    def send_push_notification(message, webpush)

        Webpush.payload_send(
          message: "",
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
