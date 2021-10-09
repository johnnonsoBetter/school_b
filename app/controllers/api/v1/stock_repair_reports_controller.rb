class Api::V1::StockRepairReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]

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
end
