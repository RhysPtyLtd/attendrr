class StudentsController < ApplicationController
	require 'students_datable'
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy,:prospectplan] # Currently does nothing??
	before_action :exceed_student_limit, only: [:create, :new, :student_attendance]

	def index
		if @club = current_club
			@students = TypeOfStudent.active_enrolled(current_club)
			#Average length of membership
			@accumulated_memberships_in_days = 0
			@students.each do |s|
				if s.active?
					n = (Date.today - s.created_at.to_date).to_i
					@accumulated_memberships_in_days += n
				else
					n = (s.updated_at.to_date - s.created_at.to_date).to_i
				end
			end
			if @accumulated_memberships_in_days && @students.count != 0
				@average_membership_length = @accumulated_memberships_in_days / @students.count
			else
				@average_membership_length = 0
			end
			# @items = Item.paginate :page => params[:page], :per_page => 5
		else
			redirect_to root_url
		end
	end

	# Add more classes to students on class package payment plans
	def buy_classes
		@student = Student.find(params[:id])
		@student.buy_classes!
		redirect_to student_path(@student)
	end

	def deactivated
		if @club = current_club
			@students = TypeOfStudent.deactivated_enrolled(current_club)
		else
			redirect_to root_url
		end
	end

	def show
		@student = current_club.students.find_by(id: params[:id])
		@student_activities = @student.unique_activities
		@first_ranks_of_activities = @student.first_ranks_of_activities
		redirect_to root_url if @student.nil?
		if @student.student_since.nil?
			@student_since = @student.created_at.strftime("%d/%m/%Y")
		else
			@student_since = @student.student_since.strftime("%d/%m/%Y")
		end
	end

	def new
		@payment_plans = current_club.payment_plans.where(active: true)
		@prospect = current_club.payment_plans.first
		@student = Student.new
		@student_ranks = @student.student_ranks.build
		# Gets an array of every rank in the club to pass to @active_ranks
		@ranks = current_club.activities.where(active: true).map { |a| a.ranks}.flatten
		# Filters out everything but the ranks that are active to pass to @first_ranks
		@active_ranks = @ranks.select { |r| r.active == true }
		# Filters out every rank but the first one
		@first_ranks = @active_ranks.select { |ar| ar.position == 1 }
	end

	def create
		@student = current_club.students.build(student_params)
		student_enrolled_on_paid_plan(student_params[:payment_plan_id])
		if @student.save
			if params[:rank_ids].present?
				puts params[:rank_ids][:id].count
				params[:rank_ids][:id].each do |id|
					student_rank = StudentRank.new(:student_id => @student.id,:rank_id => id)
					if student_rank.valid?
						student_rank.save
					end
				end
			end
			flash[:success] = "Student created!"
			redirect_to student_path(@student)
		else
			@payment_plans = current_club.payment_plans.where(active: true)
			@prospect = current_club.payment_plans.first
			@student_ranks = @student.student_ranks.build
			# Gets an array of every rank in the club to pass to @active_ranks
			@ranks = current_club.activities.map { |a| a.ranks}.flatten
			# Filters out everything but the ranks that are active to pass to @first_ranks
			@active_ranks = @ranks.select { |r| r.active == true }
			# Filters out every rank but the first one
			@first_ranks = @active_ranks.select { |ar| ar.position == 1 }
			render 'new'
		end
	end

	def edit
		@student = current_club.students.find_by(id: params[:id])
		@activities = current_club.activities.all
		@ranks = @student.club_ranks
	end

	def update
		@student = current_club.students.find_by(id: params[:id])
		student_enrolled_on_paid_plan(params[:student][:payment_plan_id])
		@ranks = @student.club_ranks
		if @student.update_attributes(student_params)
			flash[:success] = "Student details updated"
			redirect_to @student
		else
			@activities = current_club.activities.all
			render 'edit'
		end
	end

	def destroy
		@student = current_club.students.find_by(id: params[:id])
		if @student.nil?
			redirect_to root_url
		else
			@student.destroy
			flash[:success] = "Student deleted"
			redirect_to students_path
		end
	end
	def attendance
		if params[:search].present?
			@date_find = params[:search].to_date
			@prev_data = Date.parse(params[:search]) - 7.days
			@next_data = Date.parse(params[:search])+ 7.days
		else
			@date_find = params[:date_slot].present? ? Date.parse(params[:date_slot]) : Date.today
			@prev_data = @date_find - 7.days
			@next_data = @date_find + 7.days
		end
		if params[:s_id].present?
			student = Student.find_by(id: params[:s_id])
		end

		if params[:s_id].present? && !params[:remove_attendance].present?
			attendance = current_club.students.find(params[:s_id]).attendances.new
			attendance.attended_on = @date_find
			attendance.activity_id = params[:activity_id]
			attendance.timeslot_id = params[:timeslot_id]
			attendance.attended = true
			attendance.rank_id = attendance.find_rank
			attendance.save

			if student.classes_remaining.present?
				student.classes_remaining = student.classes_remaining - 1
				student.save
			end

		end
		if params[:remove_attendance].present?
			attendance = Attendance.where(timeslot_id: params[:timeslot_id],attended_on: @date_find,student_id: params[:s_id]).first
			attendance.destroy

			if student.classes_remaining.present?
				student.classes_remaining = student.classes_remaining + 1
				student.save
			end
		end

		if student.present?
			@first_name = student.first_name
			@last_name = student.last_name
			@classes_remaining = student.classes_remaining
		end

		activity = Activity.find(params[:activity_id])
		rank_ids = activity.ranks.all.pluck(:id)
		student_for_attendance = current_club.students.student_for_attendance(rank_ids)
		@student_present = student_for_attendance.left_outer_joins(:attendances).where( attendances: { timeslot_id: params[:timeslot_id],attended_on: @date_find } ).reorder(nil).sort_by(&:updated_at).reverse!
		@student_absent = student_for_attendance - @student_present

		respond_to do |format|
		  format.html
		  format.js
		end
	end
	def schedule_classes
		@student = Student.find_by(id: params[:id])
		@activity = @student.all_acitivities.uniq
	end

	def student_attendance
		# @attendance = Attendance.where(student_id: params[:student_id],activity_id: params[:activity_id])
		# @attendance.each do |a|
		# 	puts a.id
		# end
		@activity = Activity.find(params[:activity_id]) if params[:activity_id].present?
		@student = Student.find(params[:student_id]) if params[:student_id].present?
		respond_to do |format|
    	format.html
    	format.json { render json: AttendanceDatatable.new(view_context) }
  	end
	end

	def prospects
		if @club = current_club
			@prospects = TypeOfStudent.active_prospects(current_club)
		else
			flash[:success] = "Student details updated"
			redirect_to root_url
		end
	end

	def absents
    	@students = TypeOfStudent.active_enrolled(current_club)
    	@absent_alert = current_club.absent_alert
     	@absent_alert_activation_date = Date.today - current_club.absent_alert
	end

	#Used for checking whether the student enrolled on paid plan or not
	def student_enrolled_on_paid_plan(plan_id)
		if plan_id.present?
			paid_plan = PaymentPlan.find_by_id(plan_id).name !=  "Prospect"
			if paid_plan
				@student.enrolled_on = Date.today
				create_new_student_metric_record
			else
				@student.enrolled_on = ""
			end
		end
	end

	def create_new_student_metric_record
      DailyMetric.create(
        club_id: @student.club.id,
        new_students: 1
      )
	end

	private

		def exceed_student_limit
			if StudentLimit.over?(current_club)
				flash[:success] = "You've grown to the limit of this plan, well done! Upgrade and keep going!"
				redirect_to subscriptions_path
			end
		end

		def student_params
			params.require(:student).permit(:payment_plan_id, :active, :email, :address_line_1, :address_line_2, :city, :state, :postcode,:enrolled_on,
											:phone1, :phone2, :first_name, :last_name, :dob, :parent1, :parent2,
											:size, :picture, :student_since, :notes, :payment_plan_id, :classes_remaining, :student_rank, rank_ids: [],
											student_ranks_attributes: [:student_id, :rank_id, :active])
		end

		# Before filters

end
