class Api::V1::AnnouncementsController < ApplicationController
    include PermissionHelper
    include WebPushNotificationSenderHelper 
    before_action :authenticate_api_v1_admin!, only: [:create, :update, :index]
    before_action :find_admin, only: [:create, :update, :index]
    before_action :figure_status, only: [:create, :update, :index]
    before_action :find_announcement, only: :update

    def create 

        announcement = @admin.school.announcements.new announcement_params


        if announcement.save
            render json: announcement, status: :created

        else 
            render json: announcement.errors.messages, status: :unprocessable_entity
        end
    end

    def index 
        @announcements = @admin.school.announcements.includes(:announcement_image)
        render 'api/v1/announcements/index.json.jbuilder'
    end


    def update 

        

        if @announcement.update(announcement_params)
            render json: @announcement, status: :ok
        else
            render json: @announcement.errors.messages, status: :unprocessable_entity
        end

        
    end

    private

    def announcement_params 
        params.require(:announcement).permit(:message, :announcement_image_id, :expiration)
    end

    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

    def find_announcement
        @announcement = @admin.school.announcements.find_by_id(params[:id])


        unless @announcement
            render json: "Announcement Not Found", status: :not_found 
        end

    end
end
