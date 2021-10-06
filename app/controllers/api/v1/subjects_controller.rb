class Api::V1::SubjectsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index, :show]
    before_action :find_admin, only: [:create, :index, :show]
    before_action :figure_status, only: [:create, :index, :show]


    def create 

        @subject = Subject.new subject_params
        
        if @subject.save  
            render json: @subject, status: :created 
        else 
            render json: @subject.errors.messages, status: :unprocessable_entity
        end

    end


    def index 
        
        
        classroom_ids = @admin.school.classrooms.pluck(:id)
        @subjects = Subject.where(classroom_id: classroom_ids)
        
        render 'api/v1/subjects/index.json.jbuilder'
    end


    def show 
        @subject = Subject.find_by(id: params[:id])

        @students = @subject.classroom.students
        
        render 'api/v1/subjects/show.json.jbuilder'
    end

    private 
    def subject_params 
        params.require(:subject).permit(:name, :classroom_id, :teacher_id)
    end

    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
