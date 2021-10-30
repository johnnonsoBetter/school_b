class Api::V1::TeacherBehaviourReportsController < ApplicationController
    include PermissionHelper
    include WebPushNotificationSenderHelper 
    before_action :authenticate_api_v1_teacher!, only: [:create, :index]
    before_action :find_teacher, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]

    def create 
        

        @behaviour_report = @teacher.behaviour_reports.new behaviour_report_params
        
        
        if @behaviour_report.save
            send_push_notification_to_guidances("#{@behaviour_report.student.full_name} has a new report", @behaviour_report.student.guidances)

            render json: @behaviour_report, status: :created 
        else 
            render json: @behaviour_report.errors.messages, status: :unprocessable_entity 
        end
    end


    def index 

        @behaviour_reports = @teacher.behaviour_reports.where(created_at: Time.parse(params[:date]).beginning_of_day..Time.parse(params[:date]).end_of_day).includes(:teacher)
        
        render 'api/v1/teacher_behaviour_reports/index.json.jbuilder'
    end


    private
    def behaviour_report_params 
        params.require(:behaviour_report).permit(:title, :description, :behaviour_type, :student_id)
    end

    def figure_status
        check_permission_for @teacher
    end

    def find_teacher
        @teacher = current_api_v1_teacher
    end
end
