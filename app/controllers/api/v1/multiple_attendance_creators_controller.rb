class Api::V1::MultipleAttendanceCreatorsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:create]
    before_action :find_teacher, only: [:create]
    before_action :figure_status, :ensure_today_attendance, :find_classroom, :compare_class_teacher_to_current_teacher, :check_for_attendance_existence, only: [:create]

    def create 
        
        successful = false 

        debugger
        Classroom.transaction(requires_new: true) do 

            @classroom.students.each do |student|
                attend = @classroom.attendances.new student: student
    
                if attend.save 
                    successful = true
                else
                    successful = false
                    raise ActiveRecord::Rollback
                end

                
            end


        end

        

        if successful 
            @attendances = @classroom.attendances.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day).includes(:student)
            render 'api/v1/attendances/create.json.jbuilder', status: :created, message: @classroom.name
        else 
            render json: "Failed to mark attendance", status: :unprocessable_entity
        end

    end

    private
    def find_teacher 
        
        @teacher = current_api_v1_teacher
        
    end
   
    def figure_status
        check_permission_for @teacher
    end

    def find_classroom 

        @classroom = @teacher.school.classrooms.find_by_id(params[:classroom_id])
    end

    def today_is_not_allowed
       
        if Time.now.strftime("%A") == "Sunday" || Time.now.strftime("%A") == "Saturday" || @teacher.school.no_attendance == true
            return true
        else 
            return false
        end

    end

    def compare_class_teacher_to_current_teacher 
        render json: "Teacher Not Allowed To Take Attendance", status: :unauthorized if @teacher.id != @classroom.class_teacher_id
    end

    def ensure_today_attendance 
        
        render json: "You Are Not Allowed To Mark Attendance Today", status: :unprocessable_entity if today_is_not_allowed
    end

    def check_for_attendance_existence 

        if @classroom.attendances.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day).exists?
            @attendances = @classroom.attendances.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day).includes(:student)
            render 'api/v1/attendances/create.json.jbuilder', status: :ok , message: @classroom.name
        end
    end
end
