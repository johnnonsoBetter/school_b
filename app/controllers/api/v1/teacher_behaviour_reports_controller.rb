class Api::V1::TeacherBehaviourReportsController < ApplicationController
    before_action :authenticate_api_v1_teacher!, only: [:create, :index]

    def create 
        

        @behaviour_report = current_api_v1_teacher.behaviour_reports.new behaviour_report_params
        
        
        if @behaviour_report.save
            
            render json: @behaviour_report, status: :created 
        end
    end


    def index 

        @behaviour_reports = current_api_v1_teacher.behaviour_reports.where(created_at: Time.zone.parse(params[:date]).beginning_of_day..Time.zone.parse(params[:date]).end_of_day).includes(:teacher)
           
        render 'api/v1/teacher_behaviour_reports/index.json.jbuilder'
    end


    private
    def behaviour_report_params 
        params.require(:behaviour_report).permit(:title, :description, :behaviour_type, :student_id)
    end
end
