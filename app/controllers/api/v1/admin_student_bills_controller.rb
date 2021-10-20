class Api::V1::AdminStudentBillsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [ :index]
    before_action :find_admin, only: [ :index]
    before_action :figure_status, only: [ :index]


    def index 

        @bills = @admin.school.students.find_by_id(params[:student_id]).bills.includes(:payment_histories)
        render 'api/v1/admin_student_bills/index.json.jbuilder'
    end

    private
   
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
