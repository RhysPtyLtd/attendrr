class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.where(active: true).where(hidden: false)
    @students = TypeOfStudent.active_enrolled(current_club).count if current_club
    @no_stripe_subscription = current_club.stripe_customer_id.nil? if current_club
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])
    @subscriptions = Subscription.where(active: true).where(hidden: false)
    if (@subscription.active = false)
      redirect_to root_url
    end
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    unless admin?
      redirect_to root_url 
    end
  end

  # GET /subscriptions/1/edit
  def edit
    unless admin?
      redirect_to root_url 
    end
    session[:subscription] = @subscription.id
  end

  def change_hidden
    unless admin?
      redirect_to root_url 
    end
    @subscription = Subscription.find(session[:subscription])
    @subscription.toggle!(:hidden)
    redirect_to edit_subscription_path(@subscription)
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    #@subscription.destroy
    #respond_to do |format|
      #format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  def cancel
    @subscription = Subscription.find(params[:subscription])
    if @subscription.student_limit < current_club.students.where(active: true).count
      flash[:error] = "The amount of students you have exceeds the limit for that plan"
      redirect_to subscriptions_path
    end

    StripeTool.cancel_subscription(current_club)
    flash[:success] = "Subscription successfully cancelled"
    redirect_to root_url
  rescue
    flash[:error] = "Something went wrong. Please contact rhys@attendrr.com"
    redirect_to subscriptions_path
  end

  def change
    plan_changing_to = Subscription.find(params[:subscription])
    StripeTool.change_subscription(current_club, plan_changing_to)
    flash[:success] = "Subscription successfully changed to #{plan_changing_to.name}"
    redirect_to root_url
  rescue
    flash[:error] = "Something went wrong. Please contact rhys@attendrr.com"
    redirect_to subscriptions_path
  end

  def confirm_plan_change
    @current_subscription_cost = current_club.subscription.cost
    @plan_changing_to = Subscription.find(params[:subscription])
    @proration = StripeTool.calculate_proration(current_club, @plan_changing_to)
    if @plan_changing_to.student_limit < TypeOfStudent.active_enrolled(current_club).count
      flash[:error] = "The amount of students you have exceeds the limit for that plan"
      redirect_to subscriptions_path
    end
  end

  def admin
    unless admin?
      redirect_to root_url
    end
    @subscriptions = Subscription.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def admin?
      if current_club
        if current_club.admin?
          true
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:name, :cost, :student_limit, :stripe_id, :description, :active, :hidden)
    end
end
