class Api::V1::PhotosController < ApplicationController

    def create

        
        result = Cloudinary::Uploader.upload(params[:image], options = {})


        photo = Photo.create(image:   result['url'])
        if photo.save
            render json: photo
        else
            render json: photo.errors
        end
     end
end
