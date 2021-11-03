class Api::V1::AttendancesController < ApplicationController

    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:update]
    before_action :find_teacher, only: [:update]
    before_action :figure_status, :find_attendance, :compare_class_teacher_to_current_teacher, only: [:update]

    def update 
        
        if @attendance.update(attendance_params)
            render json: @attendance, status: :ok
        else 
            render json: @attendance.errors.messages, status: :unprocessable_entity
        end

    end

    private
    def find_teacher 
        
        @teacher = current_api_v1_teacher
    end
   
    def figure_status
        check_permission_for @teacher
    end

    def attendance_params 
        params.require(:attendance).permit(:is_present)
    end

    def find_attendance 

        @attendance = Attendance.find_by_id(params[:id])

        if @attendance.nil?
            render json: "Not Found", status: :not_found 
        end

    end

    

    def compare_class_teacher_to_current_teacher 
        
        render json: "Teacher Not Allowed To Take Attendance", status: :unauthorized if @teacher.id != @attendance.classroom.class_teacher_id
    end 
    
end
