class WebPushNotification < ApplicationRecord

	validates :endpoint, :p256dh_key, :auth_key, presence: true
	belongs_to :guidance
	

  	def send(message)

  		Webpush.payload_send(
		    message: "",
		    endpoint: self.endpoint,
		    p256dh: p256dh_key,
		    auth: auth_key,
		    vapid: {
		      public_key: ENV['VAPID_PUBLIC_KEY'],
		      private_key: ENV['VAPID_PRIVATE_KEY']
		    },
	    
	  	)


  	end
end
