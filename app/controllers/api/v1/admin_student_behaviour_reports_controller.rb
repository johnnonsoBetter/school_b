class Api::V1::AdminStudentBehaviourReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [ :index]
    before_action :find_admin, only: [ :index]
    before_action :figure_status, only: [ :index]
    

    def index 

        student = @admin.school.students.find_by_id(params[:student_id])
        term = TermDate.find_by_id(params[:term_id])
        
        
        @behaviour_reports = student.behaviour_reports.where(created_at: Time.zone.parse(term.start_date).beginning_of_day..Time.zone.parse(term.end_date).end_of_day).includes(:teacher)
           
        render 'api/v1/admin_student_behaviour_reports/index.json.jbuilder'
    end

    private
   
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
