class Api::V1::AdminStudentScoreReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [ :index]
    before_action :find_admin, only: [ :index]
    before_action :figure_status, only: [ :index]

    def index 



        @student = @admin.school.students.find_by_id(params[:student_id])
        @score_types = @admin.school.score_types


        if params[:term_id].present? 

            term = TermDate.find_by_id(params[:term_id])
        else 

            term = TermDate.last
        end


        @score_reports = []

        

        if params[:score_type] === 'All'
           
            @score_reports = @student.score_reports.where({created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day})
            
        else 

            @score_type = @admin.school.score_types.find_by_name(params[:score_type])
            @score_reports = @student.score_reports.where({created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day}).where({score_type_id: @score_type.id})
            

        end
        render 'api/v1/admin_student_score_reports/index.json.jbuilder'
    end

    private
   
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
