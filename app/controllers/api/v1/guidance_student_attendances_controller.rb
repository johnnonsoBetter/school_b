class Api::V1::GuidanceStudentAttendancesController < ApplicationController
    before_action :authenticate_api_v1_guidance!, only: [:index]

    def index 

        student = current_api_v1_guidance.students.find_by_id(params[:student_id])
         term = nil

        if params[:term_id].present? 

            term = TermDate.find_by_id(params[:term_id])
        else 

            term = TermDate.last
        end

         @attendances = student.attendances.where(created_at: Time.zone.parse(term.start_date).beginning_of_day..Time.zone.parse(term.end_date).end_of_day)
         @term_dates = TermDate.all


        render 'api/v1/guidance_student_attendances/index.json.jbuilder'

    end
end
