class Api::V1::CustomStudentRegistrationsController < DeviseTokenAuth::RegistrationsController

	include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]
   
    def create 


        
        successful = false
        result = nil


        
        if params[:image] != "[object Object]"

            result = Cloudinary::Uploader.upload(params[:image], :folder => "#{@admin.school.name}/students/", :overwrite => true, :public_id => "#{params[:first_name]}#{params[:last_name]}#{SecureRandom.hex(2)}@confam.sch")



        end

        
        
        @student = Student.new 
        Student.transaction(requires_new: true) do 

            @student.school = @admin.school
            @student.email = "#{params[:first_name]}#{params[:last_name]}#{SecureRandom.hex(2)}@confam.sch"
            @student.password = "#{params[:first_name]}888"
            
            @student.image = result['url'] if params[:image] != "[object Object]"


            @student.first_name = params[:first_name]
            @student.last_name = params[:last_name]
            @student.middle_name = params[:middle_name]
            # @student.lga = params[:lga]
            # @student.state = params[:state]
            # @student.religion = params[:religion]
             @student.date_of_birth = params[:date_of_birth]
            # @student.date_of_admission = params[:date_of_admission]
            #@student.address = params[:address]
            @student.classroom_id = params[:classroom_id]
            @student.gender = params[:gender]
            #@student.admission_no = params[:admission_no]


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

    def update 

        debugger

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
