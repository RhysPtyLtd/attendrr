class ClubsController < ApplicationController
  before_action :logged_in_club, only: [:edit, :update, :destroy]
  before_action :correct_club, only: [:edit, :update, :show]
  before_action :admin_club, only: [:destroy]
  before_action :admin_club_index, only: [:index]

  def index
    
  end

  def new
  	@club = Club.new
  end

  def create
  	@club = Club.new(club_params)
  	if @club.save
      @club.send_activation_email
      flash[:info] = "Please check your email to activate your account."
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

  private

  	def club_params
  		params.require(:club).permit(:name, :email, :password, :password_confirmation, :address_line_1, :address_line_2,
                                   :city, :state, :postcode, :country, :phone1, :phone2, :owner_first_name, 
                                   :owner_last_name)
  	end

    # Before filters

    # Confirms logged-in clubs
    def logged_in_club
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

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