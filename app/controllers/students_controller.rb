class StudentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def index
		if @club = current_club
			@students = @club.students.all
		else
			redirect_to root_url
		end
	end

	def show
		@student = current_club.students.find_by(id: params[:id])
		@student_activities = @student.student_activities
		@first_ranks_of_activities = @student.first_ranks_of_activities
		redirect_to root_url if @student.nil?
		
	end

	def new
		@student = Student.new
		@student_ranks = @student.student_ranks.build
		@first_ranks = current_club.first_ranks_of_activities
	end

	def create
		@student = current_club.students.build(student_params)
		if @student.save
			flash[:success] = "Student created!"
			redirect_to student_path(@student)
		else
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
		@ranks = @student.club_ranks
		if @student.update_attributes(student_params)
			flash[:success] = "Student details updated"
			redirect_to @student
		else
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
			@prev_data = Date.parse(params[:search]).prev_day
			@next_data = Date.parse(params[:search]).next_day
		else
			@date_find = Date.today
			@prev_data = @date_find.prev_day
			@next_data = @date_find.next_day
		end
		if params[:s_id].present?
			attendance = current_club.students.find(params[:s_id]).attendances.new
			attendance.attended_on = params[:date_slot]
			attendance.activity_id = params[:activity_id]
			attendance.timeslot_id = params[:timeslot_id]
			attendance.attended = true
			attendance.save
		end	
		@student_absent = current_club.students.left_outer_joins(:attendances).where( attendances: { id: nil} )
		
		@student_present = current_club.students.left_outer_joins(:attendances).where.not( attendances: { id: nil } )
		
		respond_to do |format|
		  format.html 	
		  format.js
		end
	end

	private

		def student_params
			params.require(:student).permit(:email, :address_line_1, :address_line_2, :city, :state, :postcode, 
											:phone1, :phone2, :first_name, :last_name, :dob,
											:picture, :payment_plan_id, rank_ids: [], 
											student_ranks_attributes: [:student_id, :rank_id, :active])
		end

		# Before filters

end