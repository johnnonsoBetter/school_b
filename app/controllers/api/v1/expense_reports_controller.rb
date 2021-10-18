class Api::V1::ExpenseReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]


    def create 

        @expense_report = @admin.school.expense_reports.new expense_report_params
        @expense_report.admin = @admin

        if @expense_report.save 
            render json: @expense_report, status: :created
        else 
            render json: @expense_report.errors.messages, status: :unprocessable_entity
        end


    end

    def index 

        @expense_reports = []
        @total = 0

        if params[:term_id].present?
            term = TermDate.find_by(id: params[:term_id])
            
            expense_reports = @admin.school.expense_reports
            @expense_reports =  expense_reports.where(created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day).includes(:admin)
            
        elsif params[:date].present? 
            
            expense_reports = @admin.school.expense_reports
            @expense_reports =  expense_reports.where(created_at: DateTime.parse(params[:date]).beginning_of_day..DateTime.parse(params[:date]).end_of_day).includes(:admin)
            

        elsif params[:from].present? && params[:to].present?

            
            
            expense_reports = @admin.school.expense_reports
            @expense_reports =  expense_reports.where(created_at: DateTime.parse(params[:from]).beginning_of_day..DateTime.parse(params[:to]).end_of_day).includes(:admin)
            

        end

        render 'api/v1/expense_reports/index.json.jbuilder'
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

    def date_range_params 

        params.require(:date_range).permit(:from, :to)
    end

end
