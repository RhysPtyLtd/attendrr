class ActivitiesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def new
		@activity = Activity.new
		@activity.timeslots.build
		@activity.ranks.build
	end

	def create
		@activity = current_club.activities.new(activity_params)
		if @activity.save
			flash[:success] = "New class created!"
			redirect_to activity_path(@activity)
		else
			render 'new'
		end
	end

	def edit
		@activity = current_club.activities.find_by(id: params[:id])
		@active_ranks = @activity.ranks.where(active: true)
		if !@activity.active?
			redirect_to activities_path
		else
			@activity.timeslots.build
		end
	end

	def update
		@activity = current_club.activities.find_by(id: params[:id])
		if @activity.update_attributes(activity_params)
			flash[:success] = "Class updated!"
			redirect_to edit_activity_path(@activity)
		else
			render 'edit'
		end
	end

	def show
		@activity = current_club.activities.find_by(id: params[:id])
		@active_ranks = @activity.ranks.where(active: true)
		@active_students = @activity.students.uniq
		#Average length of membership
			@accumulated_memberships_in_days = 0
			@active_students.each do |s|
				if s.active?
					n = (Date.today - s.created_at.to_date).to_i
					@accumulated_memberships_in_days += n
				else
					n = (s.updated_at.to_date - s.created_at.to_date).to_i
				end
			end
			if @accumulated_memberships_in_days.nonzero? && @active_students.count.nonzero?
				@average_membership_length = @accumulated_memberships_in_days / @active_students.count
			else
				@average_membership_length = 0
			end
			# Total number of class attendances
			@total_attendances = @activity.attendances.count
			# Total number of sessions held
			@total_sessions = @activity.attendances.count("DISTINCT(attended_on, timeslot_id)")
			# Average attendance
			if @total_attendances.nonzero? && @total_sessions.nonzero?
				@average_attendance = (@total_attendances.to_f / @total_sessions.to_f).round(2)
			else
				@average_attendance = 0
			end

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

	def scheduled_classes
		if params[:search].present?
			@date_find = params[:search].to_date
			@prev_data = Date.parse(params[:search]).prev_day
			@next_data = Date.parse(params[:search]).next_day
		else
			@date_find = Date.today
			@prev_data = @date_find.prev_day
			@next_data = @date_find.next_day
		end
		day_find = @date_find.strftime('%w').to_i
		# @activity = current_club.activities.joins(:timeslots).where('DATE(timeslots.schedule) = ?', date_find).includes(:timeslots)
		@activity = current_club.activities.joins(:timeslots).where('timeslots.day = ? AND activities.active = ? AND DATE(activities.created_at) <= ?', day_find,true,@date_find).includes(:timeslots)

		
	end

	private

		def activity_params
			params.require(:activity).permit(:name, :active, 
											 :timeslots_attributes => [:id,
																	   :time_start,
																	   :time_end,
																	   :day,
																	   :active,
																	   :schedule],
											 :ranks_attributes => [:id,
											 					   :name,
											 					   :position,
											 					   :active])
		end

end