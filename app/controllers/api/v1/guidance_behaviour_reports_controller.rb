class Api::V1::GuidanceBehaviourReportsController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index]
    def index 
        @behaviour_reports = []
        student =  @current_api_v1_guidance.students.find(params[:student_id])

        if params[:date].present? && params[:student_id].present?

           @behaviour_reports = student.behaviour_reports.where(created_at: Time.zone.parse(params[:date]).beginning_of_day..Time.zone.parse(params[:date]).end_of_day).includes(:teacher)
           

        end
        render 'api/v1/guidance_behaviour_reports/index.json.jbuilder'
    end
end
