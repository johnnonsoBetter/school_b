class Api::V1::StockRepairReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]

    def create 
        @stock_repair_report = @admin.school.stock_repair_reports.new  stock_repair_report_params
        succesfull = false

        
        @stock_repair_report.admin = @admin

        StockRepairReport.transaction(requires_new: true) do 
            Item.transaction(requires_new: true) do 
                raise ActiveRecord::Rollback if !@stock_repair_report.save 
                raise ActiveRecord::Rollback if !@stock_repair_report.item.update(quantity: @stock_repair_report.quantity) 

                if @stock_repair_report.save 
                    succesfull = true
                end


            end
        end


        if succesfull
            render json: @stock_repair_report, status: :created
        else 
            render json: @stock_repair_report.errors.messages, status: :unprocessable_entity
        end


    end


    def index 
        
        @stock_repair_reports = []

        if params[:term_id].present?
            term = TermDate.find_by(id: params[:term_id])
            
            stock_repair_reports = @admin.school.stock_repair_reports
            @stock_repair_reports =  stock_repair_reports.where(created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day).includes(:admin, :item)
            

        elsif params[:date].present? 
            
            stock_repair_reports = @admin.school.stock_repair_reports
            @stock_repair_reports =  stock_repair_reports.where(created_at: DateTime.parse(params[:date]).beginning_of_day..DateTime.parse(params[:date]).end_of_day).includes(:admin, :item)
            
        elsif params[:from].present? && params[:to].present?

                
                
            stock_repair_reports = @admin.school.stock_repair_reports
            @stock_repair_reports =  stock_repair_reports.where(created_at: DateTime.parse(params[:from]).beginning_of_day..DateTime.parse(params[:to]).end_of_day).includes(:admin)
            

        end
        render 'api/v1/stock_repair_reports/index.json.jbuilder'
    end


    private
    
    def stock_repair_report_params 
        params.require(:stock_repair_report).permit(:quantity, :item_id)

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
