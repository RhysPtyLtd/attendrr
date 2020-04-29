class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description
  before_action :logged_in?

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount,
                                      description: @description)
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
    	redirect_to (root_url) unless current_club
    end
end