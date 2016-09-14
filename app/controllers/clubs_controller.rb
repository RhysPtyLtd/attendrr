class ClubsController < ApplicationController
  before_action :logged_in_club, only: [:edit, :index, :update, :destroy] # Change :index to only admin
  before_action :correct_club, only: [:edit, :update]
  before_action :admin_club, only: :destroy

  def index
    @clubs = Club.paginate(page: params[:page]) # This is the paginated version of 'Club.all'
  end

  def new
  	@club = Club.new
  end

  def create
  	@club = Club.new(club_params)
  	if @club.save
      log_in @club
      flash[:success] = "#{@club.name} successfully created. Welcome to Class Master!"
  		redirect_to @club
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
  		params.require(:club).permit(:name, :email, :password, :password_confirmation)
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
      redirect_to(root_url) unless current_club?(@club)
    end

    # Confirms admin club
    def admin_club
      redirect_to(root_url) unless current_club.admin?
    end

end