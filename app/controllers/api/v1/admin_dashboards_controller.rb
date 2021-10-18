class Api::V1::AdminDashboardsController < ApplicationController

	include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index]
    before_action :find_admin, only: [:create, :index]
    before_action :figure_status, only: [:create, :index]

	def index 
		school = @admin.school
		@score_types = school.score_types
		@classrooms = school.classrooms
		@teachers = school.teachers
		@term_dates = TermDate.all

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
