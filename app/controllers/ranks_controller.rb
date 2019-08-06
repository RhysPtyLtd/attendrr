class RanksController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def new
		@activity = Activity.find_by(params[:id])
		@rank = @activity.ranks.new
	end

	def create
		@activity = Activity.find_by(params[:id])
		@rank = @activity.ranks.build(ranks_params)
		if @rank.save
			flash[:success] = "New rank added"
			redirect_to activity_path(@activity)
		end
	end

	def edit
		@rank = Rank.find_by(params[:id])
	end

	def update
		@rank = Rank.find(params[:id])
		@activity = @rank.activity
		if @rank.update_attributes(ranks_params)
			flash[:success] = "Class details updated"
			redirect_to edit_activity_path(@activity)
		end
	end

	private

	def ranks_params
		params.require(:rank).permit(:name, :active)
	end

end
