class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :logged_in?

  def new
    @subscription = Subscription.find(params[:subscription])
    unless @subscription.active
      redirect_to subscriptions_path
    end
    @cost = @subscription.cost
    @plan = @subscription.stripe_id
    session[:plan] = @plan
    session[:subscription] = @subscription
    @description = "#{@subscription.name} plan subscription"

    if @subscription.student_limit < current_club.students.where(active: true).count
      flash[:error] = "The amount of students you have exceeds the limit for that plan"
      redirect_to subscriptions_path
    end
  end

  def create
    @plan = session[:plan]
    @subscription = session[:subscription]
    StripeTool.create_membership(email: params[:stripeEmail],
                                  stripe_token: params[:stripeToken],
                                  plan: @plan)
    flash[:success] = "Subscription created successfully!"
    redirect_to root_url
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

    session.delete[:plan]
    session.delete[:subscription]
  end

  def thanks
  end

  private

    def amount_to_be_charged
      @amount = @cost
    end

    def logged_in?
    	redirect_to (login_path) unless current_club
    end
    
end