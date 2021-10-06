class Api::V1::ClassroomsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index, :show]
    before_action :find_admin, only: [:create, :index, :show]
    before_action :figure_status, only: [:create, :index, :show]

    def create 
        @classroom = Classroom.new classroom_params
        @classroom.school = @admin.school

        if @classroom.save  
            render json: @classroom, status: :created 
        else 
            render json: @classroom.errors.messages, status: :unprocessable_entity
        end
    end


    def index 
        @classrooms = @admin.school.classrooms
        render 'api/v1/classrooms/index.json.jbuilder'
    end

    def show 
        @classroom = @admin.school.classrooms.find(params[:id])
        @teachers = @classroom.teachers.where({permitted: true})
        render 'api/v1/classrooms/show.json.jbuilder'
    end

    private 
    def classroom_params 
        params.require(:classroom).permit(:name)
    end

    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
