class Api::V1::GuidanceScoreReportsController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index]

     
    def index 
        @score_reports = []
        student =  @current_api_v1_guidance.students.find(params[:student_id])

        if params[:date].present? && params[:student_id].present?

           @score_reports = student.score_reports.where(created_at: Time.zone.parse(params[:date]).beginning_of_day..Time.zone.parse(params[:date]).end_of_day)

        end
        
        render 'api/v1/guidance_score_reports/index.json.jbuilder'
    end
end
