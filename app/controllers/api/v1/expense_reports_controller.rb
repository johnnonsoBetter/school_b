class Api::V1::ExpenseReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]


    def create 

        @expense_report = @admin.school.expense_reports.new expense_report_params
        @expense_report.admin = @admin

        if @expense_report.save 
            render json: @expense_report, status: :created
        else 
            render json: @expense_report.errors.messages, status: :unprocessable_entity
        end


    end


    private
    
    def expense_report_params 
        params.require(:expense_report).permit(:amount, :title)

    end
    
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

end
