class Api::V1::GuidanceBehaviourReportsController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index]
    def index 
        @behaviour_reports = []
        student =  @current_api_v1_guidance.students.find(params[:student_id])

      
           @behaviour_reports = student.behaviour_reports.where({created_at: DateTime.parse(term.start_date).beginning_of_day..DateTime.parse(term.end_date).end_of_day})
            

        render 'api/v1/guidance_behaviour_reports/index.json.jbuilder'
    end
end
