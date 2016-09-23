class ActivitiesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def create
		@activity = current_club.activities.build(activity_params)
		if @activity.save
			flash[:success] = "New class created!"
			redirect_to activities_path
		else
			render 'new'
		end
	end

	def new
		@activity = Activity.new
	end

	def show
		@activity = current_club.activities.find_by(id: params[:id])
		redirect_to root_url if @activity.nil?
	end

	def index
		@activities = current_club.activities.all 
	end

	def edit
		@activity = current_club.activities.find_by(id: params[:id])
	end

	def update
		@activity = current_club.activities.find_by(id: params[:id])
		if @activity.update_attributes(activity_params)
			flash[:sucess] = "Class details updated!"
			redirect_to @activity
		else
			render 'edit'
		end
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
			params.require(:activity).permit(:name, :active)
		end
end
