class Api::V1::GuidanceBillsController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index, :show]
    def index 
        @bills = []
        student =  @current_api_v1_guidance.students.find(params[:student_id])

        @bills = student.bills
        

        render 'api/v1/guidance_bills/index.json.jbuilder'
    end

    def show 
        student =  @current_api_v1_guidance.students.find(params[:student_id])
        @bill = student.bills.find(params[:id])

        render 'api/v1/guidance_bills/show.json.jbuilder'
    end
end
