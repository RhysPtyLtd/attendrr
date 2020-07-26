class PaymentPlansController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_club, only: [:index, :show, :destroy] # Currently does nothing??

	def new
		@payment_plan = PaymentPlan.new
		@club = current_club
	end

	def create
		if params[:plan_type] == "Class package"
			params[:payment_plan][:frequency] = ""
		else
			params[:payment_plan][:classes_amount] = nil
		end
		@payment_plan = current_club.payment_plans.build(payment_plan_params)
		if @payment_plan.save
			flash[:success] = "Payment plan created"
			redirect_to action: "index"
		else
			render 'new'
		end
	end

	def index
		@payment_plans = current_club.payment_plans.all
	end

	def students
		@payment_plan = PaymentPlan.find(params[:activity])
		@payment_plan_students = @payment_plan.students.where(active: true)
	end

	def edit
		@payment_plan = current_club.payment_plans.find_by(id: params[:id])
	end

	def update
		@payment_plan = current_club.payment_plans.find_by(id: params[:id])
		if params[:plan_type] == "Class package"
			params[:payment_plan][:frequency] = ""
		else
			params[:payment_plan][:classes_amount] = nil
		end
		if @payment_plan.update_attributes(payment_plan_params)
			flash[:success] = "Payment plan updated!"
			redirect_to action: "index"
		else
			render 'edit'
		end
	end

	private

	def payment_plan_params
		params.require(:payment_plan).permit(:name, :price, :frequency, :active, :classes_amount)
	end

end
