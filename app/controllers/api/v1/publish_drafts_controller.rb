class Api::V1::PublishDraftsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:create, :index, :show]
    before_action :find_teacher, only: [:create, :index, :show]
    before_action :figure_status, only: [:create, :index, :show]
    before_action :find_score_report_draft, :check_published_status, only: :create
    
    def create 

        successfull = false

        ScoreReportDraft.transaction(requires_new: true) do 
            ScoreReport.transaction(requires_new: true) do 
                @score_report_draft.student_score_report_drafts.where(scored: true).each do |student_score_report_draft| 
                    ScoreReport.create!(
                        student: student_score_report_draft.student, 
                        teacher: @teacher, 
                        score_type: @score_report_draft.score_type, 
                        subject: @score_report_draft.subject,
                        max: @score_report_draft.max,
                        score: student_score_report_draft.score 
                    )
                   
                 end

                 if @score_report_draft.toggle!(:published) 
                    successfull = true
                 end
            end
        end

        if successfull 
            render json: @score_report_draft, status: :created
        end
 
    end

    private

    def figure_status
        check_permission_for @teacher
    end

    def find_teacher
        @teacher = current_api_v1_teacher
    end

    def find_score_report_draft 
        @score_report_draft = @teacher.score_report_drafts.find_by(id: params[:score_report_draft_id])

        unless @score_report_draft 
            render json: "Score Report Draft Not found", status: :not_found
        end
    end

    def check_published_status
        unless @score_report_draft.published === false
            render json: "Draft Report Already Published", status: :unprocessable_entity, message: "Score draft report already published"

        end
    end
end
