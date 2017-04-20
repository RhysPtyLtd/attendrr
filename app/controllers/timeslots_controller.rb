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

	def edit
		@timeslot = Timeslot.find_by(params[:id])
	end

	def update
		@timeslot = Timeslot.find(params[:id])
		@timeslot.toggle!(:active)
		@activity = @timeslot.activity
		if @timeslot.update_attributes(timeslot_params)
			flash[:success] = "Class details updated"
			redirect_to edit_activity_path(@activity)
		end
	end

	private

	def timeslot_params
		params.require(:timeslot).permit(:time_start, :time_end, :day, :active,:schedule)
	end

end