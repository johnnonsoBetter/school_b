class Api::V1::StudentScoreReportDraftsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:update]
    before_action :find_teacher, only: [:update]
    before_action :figure_status, only: [:update]


    def update 
        
        
        @student_score_report_draft = StudentScoreReportDraft.find_by(id: params[:id])

        if @student_score_report_draft.update(student_score_report_draft_params) 
            render json: "Succesffully Updated", status: :ok 
        else 
            render json: "Failed to Update", status: :unprocessable_entity
        end

    end


    private 
    def figure_status
        check_permission_for @teacher
    end

    def student_score_report_draft_params 
        params.require(:student_score_report_draft).permit(:score)
    end


    def find_teacher
        @teacher = current_api_v1_teacher
    end
end
