class PasswordResetsController < ApplicationController
  before_action :get_club, only: [:edit, :update]
  before_action :valid_club, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
  	@club = Club.find_by(email: params[:password_reset][:email].downcase)
  	if @club
  		@club.create_reset_digest
  		@club.send_password_reset_email
  		flash[:info] = "Email sent with password reset instructions"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if params[:club][:password].empty?
      @club.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @club.update_attributes(club_params)
      log_in @club
      @club.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset"
      redirect_to @club
    else
      render 'edit'
    end
  end

  private

    def club_params
      params.require(:club).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_club
      @club = Club.find_by(email: params[:email])
    end

    # Confirms valid club
    def valid_club
      unless (@club && @club.activated? && 
              @club.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token
    def check_expiration
      if @club.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end