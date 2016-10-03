class ActivitiesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def new
		@activity = Activity.new
		@activity.timeslots.build
		@activity.ranks.build
	end

	def create
		@activity = current_club.activities.build(activity_params)
		if @activity.save
			flash[:success] = "New class created!"
			redirect_to activities_path
		else
			render 'new'
		end
	end

	def edit
		@activity = current_club.activities.find_by(id: params[:id])
		if !@activity.active?
			redirect_to activities_path
		else
			@activity.timeslots.build
		end
	end

	def update
		@activity = current_club.activities.find_by(id: params[:id])
		if @activity.update_attributes(activity_params)
			flash[:sucess] = "Class updated!"
			redirect_to edit_activity_path(@activity)
		else
			render 'edit'
		end
	end

	def show
		@activity = current_club.activities.find_by(id: params[:id])
		if @activity.nil?
			redirect_to root_url
		elsif !@activity.active?
			redirect_to activities_path
		end	
	end

	def index
		@activities = current_club.activities.all 
	end

	def destroy
		@activity = current_club.activities.find_by(id: params[:id])
		if @activity.nil?
			redirect_to root_url
		else
			@activity.destroy
			flash[:success] = "Class deleted"
			redirect_to activities_path
		end
	end

	private

		def activity_params
			params.require(:activity).permit(:name, :active, 
											 :timeslots_attributes => [:id,
																	   :time_start,
																	   :time_end,
																	   :day,
																	   :active],
											 :ranks_attributes => [:id,
											 					   :name,
											 					   :position,
											 					   :active])
		end

end