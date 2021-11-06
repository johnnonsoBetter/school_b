class Api::V1::AnnouncementImagesController < ApplicationController
    include PermissionHelper
    include WebPushNotificationSenderHelper 
    before_action :authenticate_api_v1_admin!, only: [:index]
    before_action :find_admin, only: [:index]
    before_action :figure_status, only: [:index]


    def index 
        @announcement_images = AnnouncementImage.all
        render 'api/v1/announcement_images/index.json.jbuilder'
    end

    private 
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
