class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description
  before_action :logged_in?

  def new
    @subscription = Subscription.find(params[:subscription])
    @cost = @subscription.cost
    @plan = @subscription.stripe_id
    session[:plan] = @plan
  end

  def create
    @cost = session[:cost]
    @plan = session[:plan]
    StripeTool.create_membership(email: params[:stripeEmail],
                                  stripe_token: params[:stripeToken],
                                  plan: @plan)
    redirect_to thanks_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

    session.delete[:cost]
    session.delete[:plan]
  end

  def thanks
  end

  private

  	def set_description
  		@description = "Really amazing product babey yeah!"
  	end

    def amount_to_be_charged
      @amount = @cost
    end

    def logged_in?
    	redirect_to (login_path) unless current_club
    end
    
end