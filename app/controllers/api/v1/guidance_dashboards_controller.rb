class Api::V1::GuidanceDashboardsController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index]

    def index 
        @students = current_api_v1_guidance.students
        render 'api/v1/guidance_dashboards/index.json.jbuilder'
    end
end
