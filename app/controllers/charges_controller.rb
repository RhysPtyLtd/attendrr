class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description
  before_action :logged_in?
  before_action :set_plan

  def new
    @subscription = Subscription.find(params[:subscription])
  end

  def create
    if params[:subscription].include? 'yes'
      StripeTool.create_membership(email: params[:stripeEmail],
                                   stripe_token: params[:stripeToken],
                                   plan: @plan)
    else
      customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                            stripe_token: params[:stripeToken])

      charge = StripeTool.create_charge(customer_id: customer.id, 
                                        amount: @amount,
                                        description: @description)
    end
    redirect_to thanks_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private

  	def set_description
  		@description = "Really amazing product babey yeah!"
  	end

    def amount_to_be_charged
      @amount = 5000
    end

    def logged_in?
    	redirect_to (login_path) unless current_club
    end

    def set_plan
      @plan = 'plan_H8vmNO1zUmFL3U'
    end
end