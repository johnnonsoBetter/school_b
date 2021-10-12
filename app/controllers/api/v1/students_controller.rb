class Api::V1::StudentsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:index]
    before_action :find_admin, only: [:index]
    before_action :figure_status, only: [:index]

    def index 
        @students = @admin.school.students

        

        render 'api/v1/students/index.json.jbuilder'
    end

    private 
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
