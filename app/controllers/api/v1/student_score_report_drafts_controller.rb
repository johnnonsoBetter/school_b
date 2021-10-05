class Api::V1::StudentScoreReportDraftsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:update, :index]
    before_action :find_teacher, only: [:update, :index]
    before_action :figure_status, only: [:update, :index]


    def update 
        
        
        @student_score_report_draft = StudentScoreReportDraft.find_by(id: params[:id])

        if @student_score_report_draft.update(student_score_report_draft_params) 
            render json: "Succesffully Updated", status: :ok 
        else 
            render json: "Failed to Update", status: :unprocessable_entity
        end

        

    end


    def index 
        
        @student_score_report_drafts = []
        

        

            if scored_params[:scored] === "false"
                
                @student_score_report_drafts =  @teacher.score_report_drafts.find(scored_params[:score_report_draft_id]).student_score_report_drafts.where({scored: false})
                
            else
                @student_score_report_drafts =  @teacher.score_report_drafts.find(scored_params[:score_report_draft_id]).student_score_report_drafts.where({scored: true})

            end

     

        
        render 'api/v1/student_score_report_drafts/index.json.jbuilder'
    end


    private 

    def scored_params 
        params.permit(:scored, :score_report_draft_id)
    end


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
