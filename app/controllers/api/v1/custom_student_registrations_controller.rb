class Api::V1::CustomStudentRegistrationsController < DeviseTokenAuth::RegistrationsController

	include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]
   
    def create 

        debugger
        successful = false
        result = Cloudinary::Uploader.upload(params[:image], options = {})
        
        @student = Student.new 
        Student.transaction(requires_new: true) do 

            @student.school = @admin.school
            @student.email = "#{student_params[:first_name]}#{student_params[:last_name]}888@school.edu"
            @student.password = "#{student_params[:first_name]}888"
            
            @student.image = result['url']
            @student.save

            if @student.save 
                successful = true 

            end
            

        end


        if successful 
            render json: @student, status: :created 

        else 
            render json: @student.errors.messages, status: :unprocessable_entity
        end

        
    end

    private

    def student_params
        params.require(:student).permit(:first_name, :last_name, :middle_name, :classroom_id)
    end

    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
