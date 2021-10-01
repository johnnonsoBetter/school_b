class Api::V1::ScoreReportDraftsController < ApplicationController

    include PermissionHelper
    before_action :authenticate_api_v1_teacher!, only: [:create, :index, :show]
    before_action :find_teacher, only: [:create, :index, :show]
    before_action :figure_status, only: [:create, :index, :show]


    def create 
       
        successfull = false
        @score_report_draft =  @teacher.score_report_drafts.new score_report_draft_params
        
        students =  @teacher.subjects.find(@score_report_draft.subject_id).classroom.students
        
        ScoreReportDraft.transaction(requires_new: true) do 
            StudentScoreReportDraft.transaction(requires_new: true) do 
                raise ActiveRecord::Rollback if !@score_report_draft.save
                
                
                students.each do |student|
                    StudentScoreReportDraft.create! score_report_draft: @score_report_draft, student: student
                end
                
                
               if @score_report_draft.save
                    successfull = true
               end
            end
        end

        if successfull
           
            render json: @score_report_draft, status: :created
        else 

            render json: "Failed to create score draft", status: :unprocessable_entity
        end


    end


    def index 
        @score_report_drafts = @teacher.score_report_drafts.includes(:subject, :score_type)
        render 'api/v1/score_report_drafts/index.json.jbuilder'
    end

    def show 

        @score_report_draft = @teacher.score_report_drafts.find_by(id: params[:id])
        @student_score_report_drafts = @score_report_draft.student_score_report_drafts
        render 'api/v1/score_report_drafts/show.json.jbuilder'
    end




    private
    def score_report_draft_params 
        params.require(:score_report_draft).permit(:max, :score_type_id, :subject_id)
    end

    def figure_status
        check_permission_for @teacher
    end

    def find_teacher
        @teacher = current_api_v1_teacher
    end
end
