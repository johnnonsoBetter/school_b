class Api::V1::DebtRecoveredReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create]
    before_action :find_admin, only: [:create]
    before_action :figure_status, only: [:create]


    def create 

        successful = false
        @debt_recovered_report = @admin.school.debt_recovered_reports.new debt_recovered_report_params
        @debt_recovered_report.admin = @admin
      
        DebtRecoveredReport.transaction(requires_new: true) do 
            Bill.transaction(requires_new: true) do
                PaymentHistory.transaction(requires_new: true) do 
                    Student.transaction(requires_new: true) do 

                        #create a new debt recovered report
                        raise ActiveRecord::Rollback if !@debt_recovered_report.save
                        bill = @debt_recovered_report.bill
                        bill_report = bill.bill_report
                        student = bill.student

                        # create a new payment history for bill
                        payment_history = bill.payment_histories.new amount: @debt_recovered_report.amount
                        raise ActiveRecord::Rollback if !payment_history.save

                        
                        raise ActiveRecord::Rollback if bill.payment_histories.sum(:amount) > bill_report.amount

                        #updates bill paid and balance attributes
                        balance = bill_report.amount - bill.payment_histories.sum(:amount)
                        paid = bill_report.amount - balance
                        raise ActiveRecord::Rollback if !bill.update(balance: balance, paid: paid)

                        #updates the students total debt
                        total_debt = student.bills.sum(:balance)
                        raise ActiveRecord::Rollback if !student.update(total_debt: total_debt)

                        if @debt_recovered_report.save 
                            successful = true 
                        end

                    end
                end
            end

        end

        if successful 
            render json: @debt_recovered_report, status: :created
        else 
            render json: "Failed to recover debt", status: :unprocessable_entity
        end


    end


    private
    
    def debt_recovered_report_params 
        params.require(:debt_recovered_report).permit(:amount, :bill_id)

    end
    
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

end
