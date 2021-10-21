class Api::V1::SaleReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]


    def create 

        successful = false
        school = @admin.school
        @sale_report = school.sale_reports.new sale_report_params
        @sale_report.admin = @admin
        items_sold = params[:items_sold]
        

        SaleReport.transaction(requires_new: true) do 
            ItemSold.transaction(requires_new: true) do 
                Item.transaction(requires_new: true) do 

                    raise ActiveRecord::Rollback if !@sale_report.save
                    
                    items_sold.each do |item_sold| 
                       
                       item = @sale_report.item_solds.new item_id: item_sold[:item_id].to_i, quantity: item_sold[:quantity].to_i
                       
                       raise ActiveRecord::Rollback if !item.save
                    
                        
                    end

                    items_sold.each do |item_sold| 

                        item = school.items.find_by(id: item_sold[:item_id].to_i)
                        raise ActiveRecord::Rollback if item.nil?

                        item.decrement!(:quantity, item_sold[:quantity].to_i)
                        

                    end

                    total = @sale_report.item_solds.sum(:total)
                    raise ActiveRecord::Rollback if total != sale_report_params[:total].to_i



                    raise ActiveRecord::Rollback if !@sale_report.update(total: total)

                    if @sale_report.save 
                        successful = true 

                    end

                end
            end
        end



        if successful 
            render json: @sale_report, status: :created 
        else 
            render json: "Failed to create sale report", status: :unprocessable_entity
        end

    end

    def index 

        @sale_reports = []
        @total = 0
        
        if params[:term_id].present?
            term = TermDate.find_by(id: params[:term_id])
            
            sale_reports = @admin.school.sale_reports
            @sale_reports =  sale_reports.where(created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day).includes(:admin)
            @total = @sale_reports.sum(:total)

        elsif params[:date].present? 
            
            sale_reports = @admin.school.sale_reports
            @sale_reports =  sale_reports.where(created_at: DateTime.parse(params[:date]).beginning_of_day..DateTime.parse(params[:date]).end_of_day).includes(:admin)
            

        elsif params[:from].present? && params[:to].present?

            
            
            sale_reports = @admin.school.sale_reports
            @sale_reports =  sale_reports.where(created_at: DateTime.parse(params[:from]).beginning_of_day..DateTime.parse(params[:to]).end_of_day).includes(:admin)
            

        end
        @total = @sale_reports.sum(:total)
        render 'api/v1/sale_reports/index.json.jbuilder'
    end


    private
    
    def sale_report_params 
        params.require(:sale_report).permit(:total)

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
