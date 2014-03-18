class BackstageController < ApplicationController
	layout "backstage"
	def index
	  redirect_to :back unless User.find(session[:user_id]).superuser
	end
	#user manager
	def user_manager

	end
	#schedule manager
	def schedule_manager
		@user_i = User.find(session[:user_id])
	  @schedules = Schedule.paginate(:page => params[:page],:per_page => 10 )
	end
	#room manager
	def room_manager

	end
end