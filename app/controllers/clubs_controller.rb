class ClubsController < ApplicationController
  require 'metrics_datable'
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_club, only: [:edit, :update, :show]
  before_action :admin_club, only: [:destroy, :payment_plans]
  before_action :admin_club_index, only: [:index]

  def index
  end

  def new
  	@club = Club.new(absent_alert: 14)
  end

  def create
  	@club = Club.new(club_params)
  	if @club.save
      NewClubMailer.new_club_alert.deliver_now
      @club.send_activation_email
      flash[:info] = "Success! Please check your email to activate your account."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def show
  	@club = Club.find(params[:id])
  end

  def edit
  end

  def update
    if @club.update_attributes(club_params)
      flash[:success] = "Profile updated!"
      redirect_to @club
    else
      render 'edit'
    end
  end

  def destroy
    Club.find(params[:id]).destroy
    flash[:success] = "Club deleted"
    redirect_to clubs_url
  end

  def metrics
		respond_to do |format|
    	format.html
    	format.json { render json: MetricsDatatable.new(view_context) }
  	end
    @club = current_club
    @search = MetricSearch.new(params[:search])
    @metrics = @search.scope
    @params = params[:search]
    if @params.nil?
      @from = @club.created_at
      @to = Date.today
    else
      @from = params[:search][:date_from]
      @to = params[:search][:date_to]
    end
  end

  def payment_plans
    @clubs = Club.all
  end

  private

  	def club_params
  		params.require(:club).permit(:name, :email, :password, :password_confirmation, :address_line_1, :address_line_2,
                                   :city, :state, :postcode, :country, :phone1, :phone2, :owner_first_name, 
                                   :owner_last_name, :picture, :absent_alert, :subscription_id, :time_zone)
  	end

    # Before filters

    # Confirms correct club is logged in
    def correct_club
      @club = Club.find(params[:id])
      redirect_to(root_url) unless current_club?(@club) || current_club.admin?
    end

    # Confirms admin
    def admin_club
      redirect_to(root_url) unless current_club && current_club.admin?
    end

    # Confirms admin for index
    def admin_club_index
      @clubs = Club.paginate(page: params[:page]) # This is the paginated version of 'Club.all'
      redirect_to(root_url) unless current_club && current_club.admin?
    end

end
