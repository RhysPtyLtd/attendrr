class TimeslotsController < ApplicationController

	def new
		@activity = Activity.find_by(params[:id])
		@timeslot = @activity.timeslots.new
	end

	def create
		@activity = Activity.find_by(params[:id])
		@timeslot = @activity.timeslots.build(timeslot_params)
		if @timeslot.save
			flash[:success] = "Timeslot added"
			redirect_to activity_path(@activity)
		else
			render 'new'
		end
	end

	def index
		@activity = Activity.find_by(params[:id])
		@timeslots = @activity.timeslots.all
	end

	def edit
	end

	# SOLVE THIS THINGER
	def update
	end

	private

	def timeslot_params
		params.require(:timeslot).permit(:time_start, :time_end, :day, :active)
	end

end