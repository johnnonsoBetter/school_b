class Api::V1::DebtRecoveredReportsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]


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

                        #when payment has been completed update the payment completed attribute to true
                        if bill.payment_histories.sum(:amount) == bill_report.amount
                            bill.toggle!(:payment_completed)
                        end

                        #updates bill paid and balance attributes
                        balance = bill_report.amount - bill.payment_histories.sum(:amount)
                        paid = bill_report.amount - balance
                        raise ActiveRecord::Rollback if !bill.update(balance: balance, paid: paid)

                        #updates the students total debt
                        total_debt = student.bills.where({payment_completed: false}).sum(:balance)
                        raise ActiveRecord::Rollback if !student.update(total_debt: total_debt)

                        if @debt_recovered_report.save 

                           @message = params[:message]
                           
                           student.guidances.each do |guidance| 

                            debugger
                            subscription = guidance.subscription
                                Webpush.payload_send(
                                    endpoint: subscription[:endpoint],
                                    message: @message,
                                    p256dh: subscription[:keys][:p256dh],
                                    auth: subscription[:keys][:auth],
                                    vapid: {
                                        subject: ENV['SUBJECT'],
                                        public_key: ENV['VAPID_PUBLIC_KEY'],
                                        private_key: ENV['VAPID_PRIVATE_KEY'],
                                        expiration: 12 * 60 * 60
                                    }
                                )

                           end



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


    def index 

        @debt_recovered_reports = []
        @total = 0

        if params[:term_id].present?
            term = TermDate.find_by(id: params[:term_id])
            
            debt_recovered_reports = @admin.school.debt_recovered_reports
            @debt_recovered_reports =  debt_recovered_reports.where(created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day).includes(:admin, :bill)
            
            
 
        elsif params[:date].present? 
            
            debt_recovered_reports = @admin.school.debt_recovered_reports
            @debt_recovered_reports =  debt_recovered_reports.where(created_at: DateTime.parse(params[:date]).beginning_of_day..DateTime.parse(params[:date]).end_of_day).includes(:admin, :bill)
            

        elsif params[:from].present? && params[:to].present?

            
            
            debt_recovered_reports = @admin.school.debt_recovered_reports
            @debt_recovered_reports =  debt_recovered_reports.where(created_at: DateTime.parse(params[:from]).beginning_of_day..DateTime.parse(params[:to]).end_of_day).includes(:admin, :bill)
            

        end

        @total = @debt_recovered_reports.sum(:amount)

        render 'api/v1/debt_recovered_reports/index.json.jbuilder'
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

    def date_range_params 

        params.require(:date_range).permit(:from, :to)
    end

end
