class Api::V1::VapidKeysController < ApplicationController

	def index 

		@vapid_key = Base64.urlsafe_decode64(ENV['VAPID_PUBLIC_KEY']).bytes



		render json: @vapid_key, status: :ok

	end
end
