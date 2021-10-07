class Api::V1::BillReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]

    def create 

        successful = false 

        @students = @admin.school.students.where(classroom_id: params[:classroom_ids])
        
        
        
        BillReport.transaction(requires_new: true) do 
            Bill.transaction(requires_new: true) do
                Student.transaction(requires_new: true) do 

                    @bill_report = BillReport.new bill_report_params
                    @bill_report.school = @admin.school
                    @bill_report.admin = @admin
                    @bill_report.save!

                    

                    @students.each do |student| 

                        student.bills.create! bill_report: @bill_report, optional: @bill_report.optional, balance: @bill_report.amount
                        total_debt = 0
                        student.bills.where({payment_completed: false, optional: false}).each do |bill|

                            total =  bill.bill_report.amount - bill.payment_histories.sum(:amount) 
                            total_debt = total_debt + total

                        end

                        student.update!(total_debt: total_debt )

                        
                    end



                    if @bill_report.save 

                        successful = true
                    end
                end
            end

        end

        

        if successful 
            render json: @bill_report, status: :created
        end
    end


    private
    def bill_report_params 
        params.require(:bill_report).permit(:amount, :title, :optional)
    end

   

    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end
end
