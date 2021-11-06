class Api::V1::AdminDashboardsController < ApplicationController

	include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:index]
    before_action :find_admin, only: [:index]
    before_action :figure_status, only: [:index]

	def index 

		school = @admin.school
		@score_types = school.score_types
		@total_students = school.students.size
		@total_subjects = 0

		@classrooms = school.classrooms
		@teachers = school.teachers
		@term_dates = TermDate.all
		@total_debts = school.students.sum(:total_debt)
		@announcements = school.announcements.where("expiration >= ?", Date.today)
		@debt_recovered_reports =  school.debt_recovered_reports.where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day).includes(:admin, :bill).first(7)
        
        @total_debts_recovered = 0

        @debt_recovered_reports.each do |debt_recovered_report|

        	@total_debts_recovered = @total_debts_recovered + debt_recovered_report.amount
		end

		render 'api/v1/admin_dashboards/index.json.jbuilder'
	end


	private 

	def find_admin 
        @admin = current_api_v1_admin
    end

	def figure_status
		
        check_permission_for @admin
    end

    

end
