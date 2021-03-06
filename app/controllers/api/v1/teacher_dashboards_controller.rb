class Api::V1::TeacherDashboardsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, :find_teacher, :figure_status, only: [:index]
  
   
    
    
    def index 
        @score_report_drafts = @teacher.score_report_drafts.where(published: false)
        school = @teacher.school
        @score_types = school.score_types
        @term_dates = TermDate.all
        @classrooms = Set.new @teacher.classrooms
        @my_classrooms = school.classrooms.where(class_teacher_id: @teacher.id)
        
        
        render 'api/v1/teacher_dashboards/index.json.jbuilder'
    end

    private

    def find_teacher
        @teacher = current_api_v1_teacher
    end

    def figure_status
        check_permission_for @teacher
    end
end
