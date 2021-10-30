class WebPushNotification < ApplicationRecord

	validates :endpoint, :p256dh_key, :auth_key, presence: true
	belongs_to :guidance
	

  
end
