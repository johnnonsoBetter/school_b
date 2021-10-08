class Api::V1::TeacherScoreReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: :index
    before_action :find_teacher, only: [:index]
    before_action :figure_status, only: [:index]


    def index 
        
        @score_reports = []
        

        term_date = TermDate.find(params[:term_date_id])

        if params[:score_type].present? 
            score_type = @teacher.school.score_types.find_by(name: params[:score_type])
            @score_reports = @teacher.score_reports.where(subject_id: params[:subject_id], score_type_id: score_type.id, created_at: Time.zone.parse(term_date.start_date).beginning_of_day..Time.zone.parse(term_date.end_date).end_of_day).includes(:score_type, :student)
        
        else
            @score_reports = @teacher.score_reports.where(subject_id: params[:subject_id], created_at: Time.zone.parse(term_date.start_date).beginning_of_day..Time.zone.parse(term_date.end_date).end_of_day).includes(:score_type, :student)
        
        end

        render 'api/v1/teacher_score_reports/index.json.jbuilder'
    end


    private 

    def figure_status
        check_permission_for @teacher
    end

    def find_teacher
        
        @teacher = current_api_v1_teacher
        
    end
end
