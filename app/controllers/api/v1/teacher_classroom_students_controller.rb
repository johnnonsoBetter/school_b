class Api::V1::TeacherClassroomStudentsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: :index
    before_action :find_teacher, only: [:index]
    before_action :figure_status, only: [:index]



    def index 

        classroom = @teacher.school.classrooms.find_by(id: params[:classroom_id])

        @students = classroom.students
        render 'api/v1/teacher_classroom_students/index.json.jbuilder'
    end

    private 

    def figure_status
        check_permission_for @teacher
    end

    def find_teacher
        
        @teacher = current_api_v1_teacher
        
    end
end

