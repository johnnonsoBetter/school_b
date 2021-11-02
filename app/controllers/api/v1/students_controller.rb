class Api::V1::StudentsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:index, :show]
    before_action :find_admin, only: [:index, :show]
    before_action :figure_status, only: [:index, :show]

    def index 
        @students = @admin.school.students

        

        render 'api/v1/students/index.json.jbuilder'
    end

    def show 


        @student = @admin.school.students.find_by_id(params[:id])

        unless @student
            render json: "Student Not Found", status: :not_found 
        else 
            render 'api/v1/students/show.json.jbuilder'
        end

        
    end


    

    private 
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

end
