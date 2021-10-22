class Api::V1::ArticlesController < ApplicationController

	def create
	    @article = Article.new(article_params)

	    debugger

	    if @article.save
	      render :show, status: :created, location: @article
	    else
	      render json: @article.errors, status: :unprocessable_entity
	    end
  end


  # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:body, :image)
    end
end
