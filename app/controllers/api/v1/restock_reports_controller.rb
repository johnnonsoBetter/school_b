class Api::V1::RestockReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]

    def create 

        @restock_report = @admin.school.restock_reports.new restock_report_params
        @restock_report.admin = @admin
        successful = false 
        item = @admin.school.items.find_by(id: restock_report_params[:item_id])


        RestockReport.transaction(requires_new: true) do 
            Item.transaction(requires_new: true) do 
                @restock_report.save 
                raise ActiveRecord::Rollback if item.nil?
                raise ActiveRecord::Rollback if !@restock_report.save

                item.increment(:quantity, @restock_report.quantity)
                raise ActiveRecord::Rollback if !item.save

                if @restock_report.save
                    successful = true 
                end
            end

        end

        if successful
            render json: @restock_report, status: :created
        else 
            render json: @restock_report.errors.messages, status: :unprocessable_entity
        end
    end


    def index 
        
        @restock_reports = []

        if params[:term_id].present?
            term = TermDate.find_by(id: params[:term_id])
            
            restock_reports = @admin.school.restock_reports
            @restock_reports =  restock_reports.where(created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day).includes(:admin)
            

        elsif params[:date].present? 
            
            restock_reports = @admin.school.restock_reports
            @restock_reports =  restock_reports.where(created_at: DateTime.parse(params[:date]).beginning_of_day..DateTime.parse(params[:date]).end_of_day).includes(:admin)
            

        elsif params[:date_range].present?

            
            
            restock_reports = @admin.school.restock_reports
            @restock_reports =  restock_reports.where(created_at: DateTime.parse(date_range_params[:from]).beginning_of_day..DateTime.parse(date_range_params[:to]).end_of_day).includes(:admin)
            

        end
        
        render 'api/v1/restock_reports/index.json.jbuilder'
    end


    private
    
    def restock_report_params 
        params.require(:restock_report).permit(:quantity, :item_id)

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
