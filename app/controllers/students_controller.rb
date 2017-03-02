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
		redirect_to root_url if @student.nil?
	end

	def new
		@student = Student.new
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
	end

	def update
		@student = current_club.students.find_by(id: params[:id])
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
			redirect_to request.referrer || root_url
		end
	end

	private

		def student_params
			params.require(:student).permit(:email, :address_line_1, :address_line_2, :city, :state, :postcode, 
											:phone1, :phone2, :first_name, :last_name, :parent1_first_name,
											:parent1_last_name, :parent2_first_name, :parent2_last_name, :dob,
											:picture, :payment_plan_id, rank_ids: [])
		end

		# Before filters

end