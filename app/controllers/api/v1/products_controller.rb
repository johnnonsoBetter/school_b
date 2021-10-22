class Api::V1::ProductsController < ApplicationController

	def create 


		@product = Product.new image: params[:image]
		


		@product.caption = params[:caption]

		if @product.save 

			render json: @product, status: :created 
		else

			render json: @product.errors.messages, status: :unprocessable_entity
		end



	end


	private
	def product_params 
		params.require(:product).permit(:caption, :image)
	end
end
