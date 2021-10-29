class Api::V1::VapidKeysController < ApplicationController

	def index 

		@vapid_key = Base64.urlsafe_decode64(Rails.application.credentials.dig(:webpush, :public_key))


		render json: @vapid_key, status: :ok

	end
end
